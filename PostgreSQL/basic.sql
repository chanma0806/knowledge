--- 言語基礎----

--- テーブルの作成
-- 型と変数の間に「:」はいらないので注意
CREATE TABLE hoge (
    hoge text,
    fuga int
);

CREATE TABLE fuga (
    fuga int,
    fuga_text text
);

--- 行の挿入

INSERT INTO hoge VALUES('hoge', 10);
-- パラメータの指定もできる
INSERT INTO hoge(fuga, hoge) VALUES(10, 'hoge');
-- パラメータの省力も可能(未指定の場合はnullが挿入される)
INSERT INTO hoge(fuga) VALUES(10);

--- テーブルの選択

-- 全パラメータを抽出
SELECT * from hoge;
-- 任意パラメータのみを抽出
SELECT fuga from hoge;
-- where句(改行が必要)
SELECT hoge from hoge
    WHERE fuga = 10;

-- 比較演算子(不等)
-- fuga != 10な行を選択
SELECT hoge from hoge
    WHERE fuga <> 10

-- 抽出結果のソート(指定のパラメータは複数可能)
SELECT * from hoge
    ORDER BY fuga desc;
    -- asc: 昇順(初期値), desc: 降順

-- 順・行数指定
/* hogeの降順、先頭1行目から3行取得 */
SELECT hoge, fuga FROM hoge
ORDER BY hoge DESC
OFFSET 0 ROWS
FETCH NEXT 3 ROWS ONLY

/* hogeの降順、先頭３行目から1行取得 */
SELECT hoge, fuga FROM hoge
ORDER BY hoge DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY

-- インデックスの付与
/* 取得行の順列に沿ってインデックスを付与する
   下記の場合は、hogeの降順並べ替えに沿ってインデックスを行う
 */
SELECT hoge , ROW_NUMBER() OVER (ORDER BY hoge DESC) FROM hoge

--- テーブルの結合

-- 内部結合
 -- hogeかつfugaな集合
SELECT * FROM hoge INNER JOIN fuga ON(hoge.fuga = fuga.fuga)
-- 外部結合
 -- hogeかつfuga + fugaな集合
SELECT * FROM fuga LEFT JOIN hoge ON(hoge.fuga = fuga.fuga)
 -- hogeかつfuga + hogeな集合
SELECT * FROM fuga RIGHT JOIN hoge ON(hoge.fuga = fuga.fuga)
 -- hoge + fugaな集合
SELECT * FROM fuga FULL JOIN hoge ON(hoge.fuga = fuga.fuga)

--- セルの更新
UPDATE test
    SET student_name = '天才'
        WHERE point = 100;

-- セルの削除
 -- 全削除
DELETE FROM test;
 -- 一部削除(条件成立箇所のみ削除)
DELETE FROM test
    WHERE point = 0;

--- 集約関数

-- pointの最大値を抽出する場合
SELECT max(point) FROM test;
-- WHERE旬に集約関数を用いる場合
    -- pointの最大値をとった生徒名を抽出
SELECT student_name FROM test
    WHERE point = 
        (SELECT max(point) FROM test);


--- LIKE 演算子

--- fuga='like_fuga'が格納されている場合
--- %は0以上の文字列を表し、下記の例では'like_'がこれに該当し'like_fuga'が検索にヒットする
SELECT hoge FROM hoge
    WHERE fuga LIKE '%fuga'
--- 下記でも検索ヒット
SELECT hoge FROM hoge
    WHERE fuga LIKE '%fuga%'

--- BETWEEN演算子
--- 100 ~ 3000の範囲でヒットするfugaを選択。
SELECT hoge FROM hoge
    WHERE fuga BETWEEN 100 AND 3000

--- IN / NOT IN 演算子
--- 値リストのいずれか含まれるかの真偽値
SELECT hoge from hoge
    WHERE hoge IN ('hoge', 'fuga')
--- 否定形の場合
SELECT hoge from hoge
    WHERE hoge NOT IN ('hoge', 'fuga')

--- ANY, ALLL 演算子
--- 指定配列のいずれかで条件が成立する行を選択
SELECT hoge from hoge
    WHERE hoge < ANY (ARRAY[100, 1000])

--- 指定配列の全てで条件が成立する行を選択
SELECT hoge from hoge
    WHERE hoge < ALL (ARRAY[100, 1000])

--- GROUP BY旬
-- student_nameごとにpointの最大値を抽出する
SELECT max(point) FROM test
    GROUP BY student_name;

-- グループにフィルターをかけたい場合
    -- 70点以下は排除
SELECT max(point) FROM test
    GROUP BY student_name
        HAVING max(point) > 70;


-- 関数

CREATE OR REPLACE FUNCTION select_date(__date date) 
RETURNS DATE AS $$
    BEGIN
        RETURN (select _date from test where _date=__date);
    END;
$$ LANGUAGE plpgsql;


-- 型

--- CHAR型 VARCHAR型
--- CHAR型は指定バイト数でサイズ調整を行う。下記の例では格納文字数が8文字未満であっても8バイトの領域を確保する。
post_num CHAR(8)
--- VARCHAR型は格納文字数によってサイズが可変となる。
my_name VARCHAR


-- nullチェック
--- hogeにnullが格納されている行を選択
SELECT hoge FROM hoge
    WHERE hoge IS NULL

--- hogeにnullが格納されていない行を選択
SELECT hoge FROM hoge
    WHERE hoge IS NOT NULL

-- AND/OR 
/* ORよりもANDの優先順位が高いため、下記の例では条件式2,3の結果を条件式1,4のORで評価する */
SELECT * FROM hoge
    WHERE hoge = 'hoge1' /*条件式1*/
    OR hoge = 'hoge2' /*条件式2*/
    AND fuga = 'fuga1' /*条件式3*/
    OR fuga = 'fuga2' /*条件式4*/

/* ORを優先したい場合は()で条件式を括る。下記の例では条件式1,2と条件式3,4の結果をANDで評価している */
SELECT * FROM hoge
    WHERE (hoge = 'hoge1' /*条件式1*/
    OR hoge = 'hoge2' )/*条件式2*/
    AND (fuga = 'fuga1' /*条件式3*/
    OR fuga = 'fuga2') /*条件式4*/

--- 高度な機能 ----

-- ビュー
-- 抽出したテーブルを変数的に保持できる
CREATE VIEW myView asc
    SELECT max(point) FROM test;

SELECT * FROM myView;
    -- SELECT max(point) FROM testと同義;

-- 外部キー
-- 外部レコードの任意パラメーターをキーとして、レコードを紐付けする
CREATE TABLE student (
    _name text primary key,
    id int
);
CREATE TABLE test (
    _name text references student(_name),
    point int
);

-- 継承

CREATE TABLE test1 (
	_point	int,
  _name	text
);
-- test2はtest1に加えてsubjectを持つ
CREATE TABLE test2 (
	subject text 
) INHERITS(test1);


-- サーバーの起動
$ postgrs -D [database_path]

-- サーバーのクローズ
$ pg_ctl -D [database_path] stop -m smart