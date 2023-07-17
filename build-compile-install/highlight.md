##  Dependencies

```bash
sudo apt install libboost-dev lua5.4 liblua5.4-dev
```

## Install

```bash
make -j16
make PREFIX="${HOME}/.local" conf_dir="${XDG_CONFIG_HOME}/" install
```

