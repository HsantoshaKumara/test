name: My Workflow
on:
  push:
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: My Action
        uses: my-org/my-action@v1
        with:
          param1: ${{ inputs.param1 }}
