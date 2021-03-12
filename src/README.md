Welcome to your new dbt project!

### Using the starter project

Try running the following commands:

Check that all connections work:
- dbt debug --profiles-dir /home/git/dbt-demo/profiles

Clean project:
- dbt clean

Install packages:
- dbt deps --profiles-dir /home/git/dbt-demo/profiles

Compile and test all code dependencies work:
- dbt compile --profiles-dir /home/git/dbt-demo/profiles

Seed data:
- dbt seed --full-refresh --profiles-dir /home/git/dbt-demo/profiles

Running:
- dbt run --profiles-dir /home/git/dbt-demo/profiles
- dbt snapshot --profiles-dir /home/git/dbt-demo/profiles

Testing:
- dbt test --profiles-dir /home/git/dbt-demo/profiles

Documentation:
- dbt docs generate --profiles-dir /home/git/dbt-demo/profiles
- dbt docs serve --profiles-dir /home/git/dbt-demo/profiles


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
