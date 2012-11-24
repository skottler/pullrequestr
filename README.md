# Pullrequestr
### Dead simple pull request testing with [Jenkins CI](http://jenkins-ci.org)

# Installation
Pullrequestr is distributed as a Rubygem, so you can install it via `gem install pullrequestr`. RPM's and Debian packages will likely be offered at some point in the future.

Create .pullrequestr.yml in the home directory of the Jenkins user (usually `/var/lib/jenkins`):

    user: theforeman
    repository: foreman
    jenkins_baseurl: http://localhost:8080
    jenkins_individual_job: test_job
    jenkins_individual_token: SUPERFUNTOKEN
    comment_user: foreman-bot
    comment_password: thisisabadpassword

Ensure the mode of the file is `0600` so that no other users can see the password of the commenter.

Run `pullrequestr` via a Jenkins job. You should have a job that will run individual tests from the larger one that writes open pull request values. That job (called `test_job` above) will be started using the Jenkins remote access API and token-based security.

The Github API is rate limited so don't run it too often; 15 minutes is usually a good interval.

# License
This project is licensed under the GNU Public License version 3 (GPL v3). See the file called "LICENSE" in this repository for more details.
