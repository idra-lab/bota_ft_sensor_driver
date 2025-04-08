## Running the code 
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

If you want to read the data outside sudo mode you will have to add to your bashrc the following line:
```bash
export FASTRTPS_DEFAULT_PROFILES_FILE=path_to_bota_ft_sensor_driver/udp_transport.xml
```
and then run the following command:
```bash
source ~/.bashrc
```

## Adding urdf to the robot 
This package contains the URDF of the sensor and its links. You could add this URDF to the robot's `urdf.xacro` in the following way:
```
<!-- force sensor urdf -->
    <xacro:include filename="$(find rokubimini_description)/urdf/BFT_SENS_ECAT_M8.urdf.xacro" />

    <xacro:BFT_SENS_ECAT_M8 prefix="ft_sensor0" />

    <joint name="bota_ft_sensor" type="fixed">
    <parent link="${prefix}link_end"/>
    <child link = "ft_sensor0_mounting" />
    <origin xyz="0.0 0.0 0.0" rpy="${pi} 0.0 ${pi/2}" />
    </joint>
```
where link_end is the final link of the robot. 

### 3D Printed End Effector 
If you also have a 3D printed end-effector attached to the force sensor, you can export the STL and put it inside the directory where the robot's meshes are located; usually, you can find them in the `meshes` directory of the robot description package. Remember to export the .stl with the unit meter and not millimetre.

```
<link name="probe_base">
    <inertial>
      <origin rpy="0 0 0" xyz="0 0 0"/>
       <mass value="0.0"/>
       <inertia ixx="0" ixy="0" ixz="0" iyy="0" iyz="0" izz="0"/>
    </inertial>
    <xacro:common_link_visual 
        mesh_filename="lite6/visual/punta_robot"  
        origin_xyz="0 0 0.01" 
        origin_rpy="0 0 0"
        material_name="${prefix}Silver" />
    <xacro:common_link_collision 
        mesh_filename="lite6/collision/punta_robot"  
        origin_xyz="0 0 0.01" 
        origin_rpy="0 0 0" />
    </link>
    <joint name="base_tool" type="fixed">
    <parent link="ft_sensor0_wrench" />
    <child link = "probe_base" />
    <origin xyz="0.0 0.0 0.0" rpy="0.0 0.0 0.0" />
    </joint>

    <link
      name="probe">
    </link>

    <joint name="tip_tool" type="fixed">
    <parent link="ft_sensor0_wrench" />
    <child link = "probe" />
    
    <origin xyz="0.0 0.0 z_high_end_eff" rpy="0.0 0.0 0.0" />
    </joint>
```
In this case, you would have to put the .stl inside the directory `meshes\lite6\collision` and `meshes\lite6\visual`. 
