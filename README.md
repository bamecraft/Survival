# ServerTemplate

This repository is a template for create server specific repository

## Usage
1. Create repository from this template via `Use this template` button or [this link](https://github.com/bamecraft/ServerTemplate/generate)
    - **Recommended action:** Copy all branches by ✅ the `Include all branches` option
1. Create `latest` branch if you did not copy all branches from this template
1. Edit `entrypoint.sh`, `compose.yml`, `README.md`
1. Push to `develop` branch
1. When your docker image is ready to use in production, merge `develop` branch into `latest` branch
    - **Recommended action:** You might want to create new tag which matches glob listed below
    - `v?[0-9]+.[0-9]+`
    - `r?[0-9]+`
