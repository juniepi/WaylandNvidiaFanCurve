# Wayland Nvidia Fan Curve Controller FOR ARCH LINUX
**`` 💡/Information/Disclaimer/❗``**

Hello ^^ Getting started this program is for Nvidia Fan Curve Control on Wayland systems! This project has been inspired by many projects doing similar or the same thing! Specifically one project made by [Wotikama](https://github.com/wotikama/nvidiafan/tree/main) This project wouldn't have been made if Wotikama didn't make such an inspiring project so please go check them out!!! 

## ❗❗ Disclaimer ❗❗
**``/Dual GPU/Water Cooled GPU/``**

This Project is **NOT** compatible with AIO cooled OR Water cooled GPU's, Attempting to use this project with an AIO cooled or Water cooled GPU will result in **DAMAGE** or the graphics card breaking altogether!
Now with that being said this project technically can work with dual GPU's But i **WOULD NOT** recommend you try until i get conformation on an dual GPU system working with this script!

## 🌱 Getting Started
**``📦 /Packages/Guide/ 📝``**

Firstly Getting started make sure you have your nvidia driver installed! If you do not have your nvidia driver installed i recommend watching [A1RM4X's](https://www.youtube.com/watch?v=QW2XGMAu6VE) <- video on how to install nvidia drivers with one script! He covers in this video a script made by TkG that can be found [here](https://github.com/Frogging-Family/nvidia-all) which should have you covered!

Now that you have your nvidia driver installed with all the required packages that comes with it you will also need bash which more likely than not you already have installed but in case you dont the command to install bash is: 


## Bash
```
# sudo pacman -S bash
```
You also might need git! as well so go ahead and install git as well!
## Git
```
# sudo pacman -S git
```
Now you have all the packages for the starting steps! Now we have to install nvidia-settings!
## Nvidia-Settings
```
# sudo pacman -S nvidia-settings
```
## 📡 Downloading
**``🌐 /Downloading/ 📥``**

Now that you have installed Git and Nvidia-Settings you should have an application named Nvidia X Server Settings! if so that great you're ready for your next steps!

We will begin by downloading this project!
```
$ git clone https://github.com/juniepi/WaylandNvidiaFanCurve 
```
Great! We have the project you should have a file called "nvidiacurve.sh" if so drag it to a directory you want to keep this script! for example i have mine at ~/Programs/nvidiacurve.sh
Now we need to give this script execution permission which you give by going to the directory where the nvidiacurve.sh is located and inputting this command
```
$ chmod +x nvidiacurve.sh
```
Now the program has write permission! Now we can get to configuring your file! 
## 📝 Configuration
**`` 📁 /Config/Guide/ 📝``**

##  BEFORE WE START

We need to check and see if your fans are correctly labled on your system as they are in the script along with your gpu!
To do this we need to run two commands!
## Checking GPU
```
$ nvidia-smi --query-gpu=index --format=csv
```
This should give you back a number! that number is what you gpu is labeled as in your system **MOST CASES** it should be **0**

## Checking Fans
```
$ nvidia-settings -q fans
```
This should tell you the label your system gives the fans your gpu uses! in most cases they should be FAN-0 and FAN-1

## If yours is different!
Lets say after checking your gpu isnt labeled as 0!
What you will do is get your text editor! and go into your nvidiacurve.sh file and change all instances of [gpu=0] to whatever number your gpu was labeled as by your system 
~ to get into your text editor you can use vscode or anything similar or you can use nano/vim/neovim etc the command to use these are
```
$ (your editor) /Path/To/Location/Of/nvidiacurve.sh
```
~~
but if you're really new to linux i would recommend doing this in a IED like vscode! Now back to changing your GPU Number ^^ 

Example
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46" -a "[fan-1]/GPUTargetFanSpeed=46"
```
In This Situation say your gpu got labeled as 1 instead of 0 you would change the line above to
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:1]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46" -a "[fan-1]/GPUTargetFanSpeed=46"
```

Easy enough right! 

Now lets get to fans! usually fans will be labeled as FAN-0 and FAN-1, This matches up with this script as seen here
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46" -a "[fan-1]/GPUTargetFanSpeed=46"
```
But lets say you only have a FAN-0, you would remove fan-1 from the script so any instance of fan-1 will be removed as seen in the example below!
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46"
```
Now if you only had a fan-0! you should be good to go! But now lets say you have more than 2 fans the system has labeled like fan-0 fan-1 and fan-2! 
You would go into the script and change every line that has fan-0 and fan-1 to have a fan-2 as well! this would look like the line below!
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46" -a "[fan-1]/GPUTargetFanSpeed=46" -a "[fan-2]/GPUTargetFanSpeed=46"
```
It sounds a lot more complicated in directions than it actually is ^^ that should cover every issue you may run into with your labeling! Sorry for the confusing directions!

## 🌊 After checking your fan labels & GPU label

Now we have to configure your file! I use neovim you can follow along with your text editor as well! 
## Example
```
$ (your editor) /Path/To/Location/Of/nvidiacurve.sh
```
## What I Typed
```
$ nvim ~/Programs/nvidiacurve.sh
```

Now what you should see the contents of the file nvidiacurve.sh! let me explain how to configure your file!

You should see something like 
set_fan_speed() {
    local temperature=$1

this is just setting a local temp that allows the script to determine temp! So we dont need to touch this ^^
moving forward you should see a bunch of if statements dont get scared these are just your fan curve nodes!  they should look like this going downward! 
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=46" -a "[fan-1]/GPUTargetFanSpeed=46"
```
This is your first node of you fan curve! Right now you're set to my fancurve by default!
to change the temperature nodes you have to change the line below! The areas in which you have to change are determined by **!
```
if ((temperature >= *0* && temperature <= *35*)); then
```
Right now its saying if the Temp is greater than 0 but less then 35 its doing something! what this will end up doing is saying if the temperature of your GPU is more than 0 but less than 35 its making fan1 and fan0 go at whatever speed!
To change fan speeds you have to change is in the line below determined by **!
```
 sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=*46*" -a "[fan-1]/GPUTargetFanSpeed=*46*"
```
in this case you would be changing in [fan-0] and [fan-1] 46 to whatever number you want your GPU's fan to spin at that node!
to be more clear this is another example of where to change the number in which your fans speed will be at 

- sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=**YOUR NUMBER HERE**" -a "[fan-1]/GPUTargetFanSpeed=**YOUR NUMBER HERE**"

## 💤 Setting Up Sleep Timer!
The last thing left to do in the config is to setup your sleep timer! This means how long your computer will scan for updates on temperatures! for gaming i recommend you change this sleep to 15! to do this you change the like "sleep #" which is the second to last line in your script it looks something like this
```
sleep 15
```
for productivity i would reccommend you setting it to like 30!
```
sleep 30
```
## 💫 RECAP FOR THE CONFUSING INSTRUCTIONS!
Lets Recap You will change the temp threshhold by changing "temperature >= (**insert number here**) && temperature <= (**insert number here**) * this will determine the ranges in which will guide the speed of your fans!

Now lets recap what you will change to change your fan speeds! you will change 

"if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=(**INSERT NUMBER HERE**)" -a "[fan-1]/GPUTargetFanSpeed=(**INSERT NUMBER HERE**)" "
        
Change this line under whatever node range you want to edit! for example lets use the node 0 - 35 as an example! which means from temp 0C to 35C,  We will want our fans to go at whatever number you edited in the line we went over previously!
## !! DISCLAIMER !!
I have ran into issues where fans are inconsistent under the fan speed %46 so if you have issues with fan speeds not wanting to work at 46 and below! just change your speeds to 47 and above and should fix it!!!

## LAST PART
**``❗ /Important/Config info/ 📝``**

Now you should be able to setup your own fancurves! basically just plugging in numbers you want with the previous disclaimer in mind! 
but we have some more information to cover like how to turn it on and off! 
## WARNING WHEN RUNNING!
This Script stays on while you're on your pc as a terminal! SO AFTER TURNING ON THIS SCRIPT DO NOT CLOSE THE TERMINAL ITS RUNNING IN, NOT ONLY IS IT GIVING YOU INFORMATION LIKE TEMPs AND FAN SPEEDs ITS ALSO ACTUALLY CHANGING YOUR FAN SPEEDS! SO TURNING THIS SCRIPT OFF OR CLOSING THIS SCRIPTS TERMINAL IT WILL JUST KEEP YOUR GPU AT WHATEVER FAN SPEED THE SCRIPT CHANGED IT TO LAST, SO FOR EXAMPLE CLOSING OR STOPPING THE SCRIPT AT 47 SPEED BY EITHER TURNING IT OFF OR CLOSING THE TERMINAL ITS RUNNING IN, THE FAN SPEEDS OF YOUR GPU WILL BE AT 47 UNLESS YOUR EITHER RESTART YOUR PC OR RESTART THE SCRIPT BY RUNNING IT AGAIN! THIS IS A WARNING!

## 🌙 Turning Off and On The Script
To start the script you have to execute it you do this by
```
$ /path/to/nvidiacurve.sh
```
```
$ ./nvidiacurve.sh
```
You should see the terminal displaying your current Tempature and Fan speeds! This means the Script worked! 
To turn off the script at any time press CTRL + C in the terminal it was launched in! Note that your fan speed will stay to whatever it was previously set as by the nvidiacurve.sh so its not recommended to stop the script!

If it didnt show your temp or gave you an error message, then something went wrong in the install process! And for safety percausions i would reccommend restarting your pc!
So try again! or feel free to go to [Wotikama](https://github.com/wotikama/nvidiafan/tree/main) and see if their project works for you! Have fun controlling your fan curves!
