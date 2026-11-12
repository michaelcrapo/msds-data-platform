# Updates to steps taken each day.  Key lessons learned

## 2026.11.10
* learned how to setup service accounts and defining the role(s) for said account
* for uploading in python script using big query, chose WRITE_TRUNCATE over creating a staging table and merge method as we wont be incrementally updating the data.


## 2026.11.11
* set up multithreading for I/O-bound upload of olist data into bigquery.  
* created tests to make sure rows in csv file match rows in bigquery tables
* set up basic data analysis to indentify customer repurchase rate

## 2026.11.12
* tested to see if classic 80/20 rule came showed up in product rev/order totals
    - if looking at total revenue and total order count, ~22% comes from repurchasers, ~17% rev comes from repurchasers
* assessed typical ratings per product.  Found that lower 

# key command line prompts:
    ### pip, conda, source control
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
    - git rm --cached filename >> remove a specific file or folder from branch
    - git switch main >> change the branch we are editing in
        > switch -c NAME > switch to and create new branch
    - git pull >> pull the most up to date code on the current branch

    
    ### PyTest
    - pytest -v >> run the tests in the bash to see what passes
    - pytest -v -n 4 >> threading for tests

    ### dbt