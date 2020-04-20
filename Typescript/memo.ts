// プロミスの直列化

const functionPromise = (num) => {
	console.log("called at %d", num)
	const promise = new Promise((resolve, reject)=>{
		resolve(num); 
  });
  return promise;
};

const promises = [1, 2, 3, 4].map((num)=>{ 
	return () => { return functionPromise(num)};
});
const setDone = promises.reduce((pre, cur, index, array)=>{
                return pre.then(cur)
            }, Promise.resolve());