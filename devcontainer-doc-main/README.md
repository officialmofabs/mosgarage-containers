<details>
  <summary><b>Set up Docker Dev container on Mac</b></summary>

1. Install `brew` (package manager for macOS)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install VSCode
```
brew install --cask visual-studio-code
```

3. In VSCode install the 'Dev Containers' [extension]('vscode:extension/ms-vscode-remote.remote-containers'):
- press Shift+Command+X to open the extensions side-bar
- in the search bar at the top search for 'Dev Containers'
- click the 'Install' button

4. Install Docker Desktop
```
brew install --cask docker
```

5. In Mac's `Launchpad`, find the `Docker` icon and double-click it. A series of prompts follows. Choose Accept -> Use recommended settings -> Continue without signing in -> Skip survey

6. In the project folder that you want to work in copy the file called `Dockerfile`.

7. In the project folder that you want to work in copy the `.devcontainer` folder.

8. Add the following lines to your `.gitignore` file.
```
.devcontainer
Dockerfile
```

9. (OPTIONAL) If you want to use GitHub or GitLab inside the container, follow these steps (otherwise you can perform Git operations outside the container):
- make SSH key-pair for the Docker containers
```
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519-docker
```
(don't add password)
- open the id_ed25519-docker.pub file & add the contents to your [GitHub]('https://github.com/settings/keys') & [GitLab](https://gitlab.sc.ascendingnode.tech/-/profile/keys) accounts
```
cat ~/.ssh/id_ed25519-docker.pub
```
- in the Dockerfile, uncomment the commented-out block

10. Open the project folder in VSCode. Open the Command Palette (F1) and choose `Dev Containers: Rebuild and Reopen in Container`. This builds the image & starts a container from it. You can grab a coffee during the image build (takes a few minutes), but that only needs to be done once (unless the Dockerfile changes), after which you can stop and start the container as needed.

Depending on where your project folder is located, you might need to `Accept` a prompt to the effect:
`“Docker” would like to access files in your X folder.`

(Disclaimer: The image build might not work when connected to UofA VPN, but it does work if you are on campus.)

11. Now you are working in the Docker container (you can see the container live in Docker Desktop). Your project folder is mirrored in the container, so any changes you make in the container will appear on your local machine as well, but you can take advantage of packages that are installed in the container. If you stop or destroy the container, the changes persist on you local machine. You can stop a container (by closing the VSCode window) and start it again later (by reopening a window and reconnecting to the container).

<b>DO NOT</b> push this image to Docker Hub (or anywhere) if it contains an SSH key that you have authorized to GitHub & GitLab.
</details>




<details>
<summary><b>Set up Docker Dev container on Windows</b></summary>

1. Install VSCode: go to [https://code.visualstudio.com/download](https://code.visualstudio.com/download) and click on the download button for `Windows 10, 11`. This should trigger the download of a `.exe` file. Double-click the downloaded file to trigger the install:
- Select 'I accept the agreement' and click 'Next' to accept the License Agreement & continue.
- Click 'Next' to accept default install destination
- Click 'Next' to accept default Start Menu folder in which to add shortcuts
- Click 'Next' to accept the default extra tasks
- Click 'Install'. This shouldn't take longer than 1-2 minutes. Once it's done, click 'Finish' and VSCode will launch.

2. In VSCode install the 'Dev Containers' [extension]('vscode:extension/ms-vscode-remote.remote-containers'):
- press Shift+Ctrl+X to open the extensions side-bar
- in the search bar at the top search for 'Dev Containers'
- click the 'Install' button

3. Docker Desktop requires Windows Subsystem for Linux (WSL) to be installed first. Follow the steps [here](https://learn.microsoft.com/en-us/windows/wsl/install) if WSL is not already enabled on your Windows. 

4. Install Docker Desktop: go to [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/) and select `Download for Windows`. Double-click the `Docker Desktop Installer` and follow the instructions on the installation wizard to authorize the installer and proceed with the install. If presented with the choice, choose to use 'WSL 2' instead of 'Hyper-V' (if your system only supports one of the two options, you will not be able to select which backend to use).

5. Search for `Docker`, and select `Docker Desktop` in the search results. A series of prompts follows. Choose Accept -> Use recommended settings -> Continue without signing in -> Skip survey

6. In the project folder that you want to work in copy the file called `Dockerfile`.

7. In the project folder that you want to work in copy the `.devcontainer` folder.

8. Add the following lines to your `.gitignore` file.
```
.devcontainer
Dockerfile
```

9. (OPTIONAL) If you want to use GitHub or GitLab inside the container, follow these steps (otherwise you can perform Git operations outside the container):
- make SSH key-pair for the Docker containers
```
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519-docker
```
(don't add password)
- open the id_ed25519-docker.pub file & add the contents to your [GitHub]('https://github.com/settings/keys') & [GitLab](https://gitlab.sc.ascendingnode.tech/-/profile/keys) accounts
```
cat ~/.ssh/id_ed25519-docker.pub
```
- in the Dockerfile, uncomment the commented-out block

10. Open the project folder in VSCode. Open the Command Palette (F1) and choose `Dev Containers: Rebuild and Reopen in Container`. This builds the image & starts a container from it. You can grab a coffee during the image build (takes a few minutes), but that only needs to be done once (unless the Dockerfile changes), after which you can stop and start the container as needed.

Depending on where your project folder is located, you might need to `Accept` a prompt to the effect:
`“Docker” would like to access files in your X folder.`

(Disclaimer: The image build might not work when connected to UofA VPN, but it does work if you are on campus.)

11. Now you are working in the Docker container (you can see the container live in Docker Desktop). Your project folder is mirrored in the container, so any changes you make in the container will appear on your local machine as well, but you can take advantage of packages that are installed in the container. If you stop or destroy the container, the changes persist on you local machine. You can stop a container (by closing the VSCode window) and start it again later (by reopening a window and reconnecting to the container).

<b>DO NOT</b> push this image to Docker Hub (or anywhere) if it contains an SSH key that you have authorized to GitHub & GitLab.
</details>