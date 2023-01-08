https://nvie.com/posts/a-successful-git-branching-model/

https://github.com/borisskert/release-scripts

https://danielkummer.github.io/git-flow-cheatsheet/index.ru_RU.html


```
release | feat | start
        | fix  | merge
        | rc   | finish
        
feat - New features
fix - Hotfixes
rc - Release candidates

release feat start feat-2243

start - start new branch
merge - Слияние изменений в ветку dev (main)
```