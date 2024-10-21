# JetBrains Remote Development with DevContainers
Examples of using DevContainers with JetBrains IDE.

Containers have brought the ability to deploy the same environments to production as are used during development and testing.
The Infrastructure as Code approach (using tools like Terraform and Ansible), along with container orchestration systems like Kubernetes,
has allowed for the complete configuration of server infrastructures used in the operation of development solutions.

## Preconditions
### Infrastructure as a Code. Reproducible infrastructures.
This approach has been actively adopted, proving its utility:
- Solutions have become more reliable,
- Dev, staging, and production environments have become identical and repeatable,
- Updates have been simplified,
- Deployment time has been reduced,
- Scaling has been simplified,
- The impact of human error has been reduced,
- The operation of high-availability solutions has been simplified (using techniques like green-blue deployment and others).

### Containerization. Reproducible environments.
With the help of Docker, Docker Compose, and Kubernetes, containers have begun to be used in the development process.
After writing the code, the solution is deployed and debugged in containers.

## DevContainers. Reproducible development environments
The DevContainers approach allows for placing a fully functional development environment in containers:
- Running applications
- Running IDEs and tooling
- Appropriate versions of libraries and dependencies
- Runtimes required by a specific codebase and project, used in continuous integration and testing.
- Simple onboard new people (The development environment is configured automatically.)
- The goal of DevContainers is to provide a fully functional, reproducible development environment along with an IDE.

DevContainers help save a lot of time setting up the development environment, especially during the onboarding of new employees to a project.
For new colleagues, it often translates to reading tons of documentation.
Besides coding, developers frequently spend time figuring out which dependencies are needed to make the code work.
Or the code was written on macOS and for some reason, it doesn't work when run on Windows. What could have gone wrong? :)

JetBrains development environments are introducing built-in support for DevContainers.
DevContainers come pre-configured with the required environments and dependencies as needed for your project.
You can also create your own DevContainer and customize it once, then use it as much as needed.
In DevContainers, the source code of your application becomes available without the need for manual uploading
(via source mounting or creating a DevContainer from a repository over SSH).

When you connect to a DevContainer, your developer experience is the same as when working locally.
This works thanks to the Remote Development technology, where an IDE server runs inside the container and a local frontend,
which exchange only the changes in the view in a very fast and efficient manner thanks to the RD protocol.

In this repository, you will find several examples that will help you learn how to use DevContainers with the JetBrains 2023.3 IDEs release.
**To work with the examples, Open each example folder as a project in IntelliJ IDEA.**

## Table of Contents
### QuickStart_0 – Simple Ubuntu devcontainer.
You can try running the script on your desktop operating system and in the DevContainer.
This is the simplest example.

### UseFeatures_1 – Simple devcontainer.json features example
In this example, the use of DevContainer Features is demonstrated.
A feature - support for Golang - is installed on the selected image.
You can try to build the application in the DevContainer and convert a jpg into an ascii image.

### Compose_2 – devcontainer.json for a Golang project using Docker Compose and having a legacy MongoDB dependency.
In this example, we launch a DevContainer from Goland (make sure to open the project correctly in this IDE).
By clicking on the gutter in devcontainer.json, our docker-compose.yml will spin up a dependency – an older version of MongoDB
in a separate container, and the main container with Go for development. We can connect to the database from the Database
Explorer in Goland using the host address: mongodb. We can build the project with go build and test its functionality.
All necessary dependencies are already set up.


