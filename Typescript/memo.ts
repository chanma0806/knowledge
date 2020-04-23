/**
 * プロミスの直列化
 */

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


/**
 * 例外処理をローカル・チェーン全体の２種で切り分けしたい場合のプラクティス
 */

Promise.resolve().then(() => {
  return this.hoge()
  // ローカルスコープに閉じたい処理
  // 成功
  .then((responses)=> Promise.resolve(responses))
  // 失敗
  .catch((error)=>{
      
  })
})
.then(() => {
  return this.fuga();
})
.catch((error) => {
  // プロミスチェーン上の例外処理    

}).finally(()=>{
  // プロミスチェーン上の最終処理
});