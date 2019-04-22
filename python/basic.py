import pandas as pd

# 言語基礎

## 真偽値

### 真偽値の逆転

    # !ではなくnotで記述
    def isHoge(source):
        return source == "hoge"

    if not isHoge("hoge"):
        print("not hoge")

## class

class Hoge:
    def __init__(self, fuga):
        self.fuga = fuga

    @staticmethod
    def static_method():
        return 0
    @classmethod
    def class_method(self):
        return 0

    # プライベートは__関数名で記述（ここではstaticなプライベート）
    @staticmethod
    def __Private_method():
        return 0

## 可変長引数

### 可変長引数をタプルとして扱う
def studyArgs(*args):
    print(args)
studyArgs(1, 2, 3)
# > (1, 2, 3)

### 可変長引数を辞書として扱う場合
def studykwargs(**kwargs):
    print(kwargs)
studykwargs(a=1, b=2)
# > {"a": 1, "b" : 2}

## インスタンスの確認

### メンバー変数の確認
vars(hoge) # メンバーの型までチェックできる

### インスタンスのローカルスコープに存在する名前のリスト
dir(hoge) # 名前のみを抽出するためmethod名も引き出せる

## モジュールとパッケージ

'''
Pythonでは拡張子"py"のファイルはモジュールと見なされる
下記は"hoge.py"のprintHogeをimportしている
'''
from hoge import printHoge

'''
class等も一つのモジュール記載することができるが、保守性の観点でファイル分割をしたくなる場合がある。
その場合、複数モジュールをimportする必要があるため、下記のようなimportを記述することになる
'''
from hoge1 import Hoge1
from hoge2 import Hoge2

'''
上記を回避するために、パッケージという概念が存在する。
具体的には１ディレクトリの中で複数モジュールを配置する。
__init__.pyも同ディレクトリには配置するし、下記の様な記述をするとパッケージ一括でimport文を記述できる
'''

### hoge/__init__.py
from .hoge1 import Hoge1
from .hoge2 import Hoge2

### main.py
from hoge import Hoge1, Hoge2

# pandas基礎

### Dataframe・Seriesの各要素に関数を当ててたい場合
df = df.applymap(hoge) #Dataframe全要素にhoge()を実行
df["fuga"] = df["fuga"].apply(hoge) #Series全要素にhoge()を実行

### dataframeの表示サイズ調整
pd.set_option("display.max_colwidth", 50)
    # カラムの横幅の最大文字数を50文字にする