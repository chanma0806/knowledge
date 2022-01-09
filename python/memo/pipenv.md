## エラーナレッジ

> pipenv lockの失敗

**発生バージョン**

`pipenv`
- 2021.11.23

`python`
- 3.9.9

**エラーログ**

```log
Creating a virtualenv for this project...
Pipfile: /tmp/Pipfile
Using /usr/local/bin/python3.9 (3.9.9) to create virtualenv...
⠸ Creating virtual environment...created virtual environment CPython3.9.9.final.0-64 in 230ms
  creator CPython3Posix(dest=/root/.local/share/virtualenvs/tmp-XVr6zr33, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==21.3.1, setuptools==58.3.0, wheel==0.37.0
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

✔ Successfully created virtual environment! 
Virtualenv location: /root/.local/share/virtualenvs/tmp-XVr6zr33
Locking [dev-packages] dependencies...
Locking [packages] dependencies...
Building requirements...
Resolving dependencies...
⠙ Locking..✘ Locking Failed! 

[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/resolver.py", line 743, in _main
[ResolutionFailure]:       resolve_packages(pre, clear, verbose, system, write, requirements_dir, packages, dev)
[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/resolver.py", line 704, in resolve_packages
[ResolutionFailure]:       results, resolver = resolve(
[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/resolver.py", line 685, in resolve
[ResolutionFailure]:       return resolve_deps(
[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/utils.py", line 1370, in resolve_deps
[ResolutionFailure]:       results, hashes, markers_lookup, resolver, skipped = actually_resolve_deps(
[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/utils.py", line 1099, in actually_resolve_deps
[ResolutionFailure]:       resolver.resolve()
[ResolutionFailure]:   File "/usr/local/lib/python3.9/site-packages/pipenv/utils.py", line 877, in resolve
[ResolutionFailure]:       raise ResolutionFailure(message=str(e))
[pipenv.exceptions.ResolutionFailure]: Warning: Your dependencies could not be resolved. You likely have a mismatch in your sub-dependencies.
  You can use $ pipenv install --skip-lock to bypass this mechanism, then run $ pipenv graph to inspect the situation.
  Hint: try $ pipenv lock --pre if it is a pre-release dependency.
ERROR: Disabling PEP 517 processing is invalid: project specifies a build backend of setuptools.build_meta in pyproject.toml
```

**エラー要因**

- `pipenv lock`実行時に`notebook`の依存関係が整理されずに終了した。

**解決方法**

- `pipenv install [module]`で、依存関係の解決に失敗するモジュールだけ直接installし、lockファイルを作成しておく<br>
  以後は、コマンドで自動生成された`Pipfile`に追記