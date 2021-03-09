# Jenkins README - Notes for setting up pipeline

1) Setup Github project and whether you allow concurrent builds (we dont) \
<img src="./images/image_example_url_settings.png" alt="Image of example URL settings" style="width:600px;"/>

2) To simulate our internal environment, we setup a polling solution (1 minute for testing!) \
<img src="./images/image_example_polling.png" alt="Image of example polling" style="width:600px;"/>

3) To overcome [this Jenkins bug](https://stackoverflow.com/questions/46684972/jenkins-throws-java-lang-illegalargumentexception-invalid-refspec-refs-heads), we disable lightweight checkout AND set branches to */*, and NOT any of: [EMPTY, NULL, *] \
<img src="./images/image_bugfixing_branch_and_lightweight.png" alt="Image of example URL settings" style="width:600px;"/>

4) It runs Build, Test, Deploy according to our [Jenkinsfile](./../../Jenkinsfile)

