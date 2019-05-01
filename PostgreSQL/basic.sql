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