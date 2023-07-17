## Install Dependencies

```
apt install python3-dev libpython3-dev python3-pip python3-setuptools python3-pyqt5 git python3-lxml python3-bs4 python3-xmltodict python3-markdown
```

```
pip3 install textile
```



## Build & Install

* `git clone https://github.com/BasioMeusPuga/Lector`

* `cd Lector`

* Build:

  ```
  $ python3 setup.py build
  ```

* In the subdirectory `lector/resources/raw/`, rename: 

  `io.github.BasioMeusPuga.Lector.desktop` > `lector.desktop`

  `io.github.BasioMeusPuga.Lector.metainfo.xml` > `lector.metainfo.xml`

* Install (Do NOT use pip3 as `Lector` errors out)

  ```
  sudo python3 setup.py install
  ```



## Reference



### Required Dependencies

| Package               | Version tested |
| --------------------- | -------------- |
| Python                | 3.6            |
| PyQt5                 | 5.10.1         |
| python-lxml           | 4.3.0          |
| python-beautifulsoup4 | 4.6.0          |
| python-xmltodict      | 0.11.0         |



### Optional Dependencies

| Package          | Version tested | Required for     |
| ---------------- | -------------- | ---------------- |
| python-pymupdf   | 1.14.5         | PDF support      |
| python-djvulibre | 0.8.4          | DjVu support     |
| python-markdown  | 3.0.1          | Markdown support |
| textile          | 3.0.4          | TXT support      |

---



### [can someone provide install instructions for Ubuntu 16.0.4 LTS? #20](https://github.com/BasioMeusPuga/Lector/issues/20)

Got this to run on Ubuntu Budgie 18.04 (GNOME) through manual build. Here's the commands if it helps others:

```
sudo apt update
sudo apt -y upgrade
python3 -V
sudo apt install -y python3-pip python3-dev python3-pyqt5 git
pip3 install pyqt5 lxml beautifulsoup4 xmltodict pymupdf setuptools
cd ~ && git clone https://github.com/BasioMeusPuga/Lector.git
cd Lector && python3 setup.py build
sudo python3 setup.py install
lector/__main__.py
```