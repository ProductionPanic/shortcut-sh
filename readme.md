# Shortcut cli tool
## Installation
```sh
git clone github.com/ProductionPanic/shortcut-sh ./shortcut-sh
cd ./shortcut-sh
source ./install.sh
echo "Shortcut cli was installed"
```

## Usage
### Registering a new command
To register a new command/alias you run the following:
```sh
shortcut rf rm -rf
```
This will place the following in your `.bashrc` file:
```sh
alias rf="rm -rf"
```
so now you can call it by just running `rf`

