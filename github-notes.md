#### CS 3270 – Programming Languages

# GitHub Notes

Information on how to use Git/GitHub on the command line.

## Clone (or download) repository from GitHub

To clone a repository open a Command Prompt or PowerShell (in Windows) or Terminal (in MacOS). Navigate to the folder where you want the cloned folder from GitHub to reside in and run the following command:

```
git clone <remote_repo>
```

Replace `<remote_repo>` with the URL of your assigned repository on GitHub. The URL can be copied by clicking on **Code**. Make sure **HTTPS** is selected and copy the provided URL.

If you are asked to login, you will need to create a *personal access token* on the [GitHub website](https://github.com/settings/tokens) (if you saved your token from Homework 0, you can use that instead). Select **Generate new token**. On the next page, enter a name for the token. The default expiration is set for 30 days. You should set this to a minimum of 90 days so you can use the same token for the entire semester (if you forget to increase the expiration, then you can just regenerate a token when this token expires). Under **Select scopes**, if not already checked, make sure to check **repo** and **workflow**. Then scroll all the way to the bottom of the page and click **Generate token**. A personal token will be generated. Click on the clipboard icon to the right of the token text to copy the token to your computer's clipboard. This token is like a password. If you want to save it, make sure to save it in a secure place. Back to the command line, after entering your GitHub username, paste the token when you are asked for a password.

## Commit

Once you are ready to commit some code, go back to the command prompt or terminal and go into (i.e., `cd`) the repository's root folder.

You must first *stage* the files that you want to commit. Note that this step needs to be done before actually committing the file(s). This step was not needed in CLion or IntelliJ IDEA, because it is done automatically for you.

The following command will add (or stage) all files that can be committed in the local repository:

```
git add .
```

If you would like to stage/commit a specific file, then replace the period in the command above with the name of the file. Note that any other files that have changed will not be staged/committed.

If you receive a warning "warning: LF will be replaced by CRLF ...", you can ignore the warning.

Now that you have added (or staged) the files to be committed, you can perform commit step. Run the following command:

```
git commit -m "<message>"
```

You should replace `<message>` with a brief description of what was committed.

## Push commits to GitHub

Once you've committed, you can push the commits to GitHub. Run the following command:

```
git push
```

It is recommended that you go to your repository on GitHub to confirm that the push completed successfully.

You may commit/push as many times as you want. However, make sure that your last commit/push is before the deadline to avoid a late penalty.