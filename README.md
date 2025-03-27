Before starting the ros packege we need to check which is the port of the Bota f/t tensor. To do this we need to run the following command:
```bash
ip addr
```
if you can not understeand which is the port disconnect all the other device connetcet via ethernet to the PC and run the command again. The port that is left is the one of the Bota f/t tensor.

Inside the file 'bota_driver/rokubimini_ethercat/launch/rokubimini_ethercat.launch.py' we need to change the parameter 'ethercat_bus' with the port of the Bota f/t tensor. For example if the port is 'eno1' the file should look like this:
```python
    {
        'ethercat_bus': 'eno1'
    },
```

After building the package, we need to go in sudo mode with the following command:
```bash
sudo su
```
and then run the following command:
```bash
. ft.sh
```
This command will start the Bota f/t tensor and the rokubimini_ethercat node.

To reset the sensor use the following command:
```bash
. reset.sh
```

