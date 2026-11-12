# Updates to steps taken each day.  Key lessons learned

## 2026.11.10
* learned how to setup service accounts and defining the role(s) for said account
* for uploading in python script using big query, chose WRITE_TRUNCATE over creating a staging table and merge method as we wont be incrementally updating the data.
* key command line prompts learned:
    - deactivate
    - conda deactivate
    - source .venv/bin/activate >> how to activate the projects proper environment
    - pip freeze > requirements.txt >> how to dependencies to a requirements filer
    ### GITHUB
    - git add FILENAME.FILETYPE >> adds specified file or folder to current branch, waits to be commited
    - git status >> list the updates that are waiting to be commited
    - git commit -m "COMMIT TITLE"
    - git push
    - gh pr create --base main --title "" --body ""
    - gh pr merge --merge --delete-branch
    
    ### PyTest
    - pytest -v >> run the tests in the bash to see what passes
    - pytest -v -n 4 >> threading for tests

## 2026.11.11
* set up multithreading for I/O-bound upload of olist data into bigquery.  
* created tests to make sure rows in csv file match rows in bigquery tables