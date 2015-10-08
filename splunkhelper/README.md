## Description

   Well what is that *splunkhelper*? Let me ask your some questions because those were mine a while ago:<br>
   
- Have you ever started splunk> as the wrong user (oh well if you *HAVE* - you know what I mean)?<br>
- Are you sick of all those long commands to apply the cluster bundle, reload deployment classes,....?<br>
- Do you want to ease up your (splunk>) life - especially (but not only) in large environments?<br>

Just configure this helper as described in the *"Install"* section and begin using splunk> **"worry-free"**!

**Features & Advantages when using splunkhelper:**
- Never worry about doing splunk> related commands with the correct user
- No need to switch from user >root< to your splunk user (privileges gets dropped automagically)
- Ease up your life by entering simple shortcuts instead of non-rememberable arguments
- Simply execute splunk commands regardless in which path you're currently in
- Enhancements for daily usage inside (e.g. *splunkexchange* or detecting HA installations)

   Note:   
   Since splunk> v6.1.1 a variable *SPLUNK_OS_USER* exists which ensures splunk is not started as root.
   Setting this Variable is a good idea (see install for the details) - but as a fallback only.
   That variable avoid only but nothing else. There is no more intelligence behind like splunkhelper has.
   So if something goes totally wrong it will come in place but it will not make things easier.
   The biggest advantage of splunkhelper is that even when you're *root* you can use splunk related
   commands without switching the user! The logic inside splunkhelper let you execute whatever you like
   but without carrying about the correct user permission.
   
   *Using the variable + this helper will make your splunk installation as much immutable as possible!*
   
## Usage:

   Use **"splunk -h | --help"** at anytime to get usage info for the splunkhelper!
   
   Use **"splunk help"** to get the normal splunk help info!

   Simply use **"splunk"** and you can use **all** arguments like with /opt/splunk/bin/splunk (!!) but with the powers
   of splunkhelper!
   
   Execute one of the following shortcut commands to do a quick action.

## Command shortcuts:

    IMPORTANT HINT:
    If you want help for the REAL splunk command simply execute "splunk help" instead!
    
    **************
    * USAGE INFO *
    **************
    
    -h | --help         This help/usage info
    --helperupdate      Easy self-update the splunkhelper. Needs root permission.
                        You CAN specify an URL to the update ZIP - if you like. Otherwise the default update
                        URL is used (stable releases by default).
                        It will download the new version and install it automatically afterwards.
                        
                        Defining a custom update URL enables you to deploy a new version of splunkhelper for your
                        internal network when not every server has access to the internet or if you want to
                        download an unstable/developer version of splunkhelper.
                        You can combine "splunkexchange" with "splunk --helperupdate <URL>". Nice isnt it? ;)
                        
                        Example:
                        splunk> server "A" download a new splunkhelper version from git
                        and you want to deploy it on splunk> server B:
                        1) (A) --> $> cd /tmp
                        2) download the latest stable release:
                           (A) --> $> wget https://github.com/xdajog/splunk/archive/master.zip
                            or if you like it bleeding edge:
                           (A) --> $> wget https://github.com/xdajog/splunk/archive/dev_splunkhelper.zip
                        3) (A) --> $> splunkexchange 5555
                        4) start the update on server B as user "root" (otherwise you cannot install):
                           (B) --> #> splunk --helperupdate http://serverA:5555/master.zip (or "dev_splunkhelper.zip")
    
    Non specific splunk> commands (executable on every server type):
    ****************************************************************************************************************
    $> splunk                       Provides direct access to splunk binary but with the powers of splunkhelper!
                                    (real exec: like "/opt/splunk/bin/splunk" )
                                        
    $> splunkrestart                Restarts splunk
                                    (real exec: "restart")
                                        
    $> splunkwebrestart             Restarts splunk web interface (no effect since splunk> v6.2 because it is no separate
                                    daemon anymore... If you want to restart the web in >=6.2 use splunk restart instead)
                                    (real exec: "restartss")
                                        
    $> splunkdebug                   Executes btool debug check
                                    (real exec: "btool --debug check")
                                        
    $> splunkstop                   Stops splunk
                                    (real exec: "stop")
                                        
    $> splunkstart                  Starts splunk
                                    (real exec: "start")
                                        
    $> splunkstatus                 Status of splunk and helper processes
                                    (real exec: "status")

                                        
    Specific splunk> commands (executable on specific server types only):
    ****************************************************************************************************************
    $> splunkshcapply               Apply configuration bundle within a Search Head Cluster
                                    (real exec: "apply shcluster-bundle -target xxxx")
                                    You can execute this on the Deployer or on the CM because
                                    it will ask you for a SH cluster member.
                                    If you execute it on a SH cluster member server it will catch the cluster members
                                    for you and their status for easy copy & paste                               

    $> splunkcmapply                Apply configuration bundle within a index cluster
                                     (real exec: "apply cluster-bundle")
                                    --> This will work on a Cluster Master (CM) only (will abort if not on CM)
                                        
    $> splunkclustershow            Shows the current cluster status
                                    (real exec: "show cluster-status")
                                    --> This will work on a Cluster Master (CM) only (will abort if not on CM)
                                        
    $> splunkclustershowbundle      Shows the current status of cluster bundle config
                                    (real exec: "show cluster-bundle-status")
                                    --> This will work on a Cluster Master (CM) only (will abort if not on CM)
                                        
    $> splunkclusterlistpeers       Shows the peers status connected to an index cluster
                                    (real exec: "list cluster-peers")
                                    --> This will work on a Cluster Master (CM) only (will abort if not on CM)

    $> splunkdsreload               Reloads the deploymentservers classes to deploy changes if needed.
                                    (real exec: "reload deploy-server")
                                    --> This will work on a Deployment Server (DS) only (will abort if not on DS)
    
    General commands (not directly splunk> related):
    ****************************************************************************************************************    
    $> splunkexchange               Requires python (provides the server module) and perl (for the timeout).
                                    Starts a simple python http server in the CURRENT directory. You can specify
                                    a tcp port - if not: default is 8888.
                                    **DUE TO SECURITY REASONS IT WILL STOP AFTER 300 SECONDS AUTOMATICALLY!**
                                    Really helpful when deploying things..
                                    (real exec: "python -m SimpleHTTPServer <PORT>")
                                    Really helpful for updating splunkhelper in large environments!
                                    Checkout --helperupdate to combine splunkexchange with updating.

                                    Example 1:
                                    "$> splunkexchange" --> will start a webserver in the current directory
                                    on port 8888. If your hostname is "foo" you can then download all files of
                                    that directory by pointing to http://foo:8888/

                                    Example 2:
                                    "$> splunkexchange 9999" --> will use port 9999 instead


## Installation (the EASY bulletproof way):

1. as **>root<** or by using **sudo**:
        #> make install

2. if splunk version **>= 6.1.1**: Set/Check the fallback splunk user variable:
            (splunk)$> vim /opt/splunk/etc/splunk-launch.conf
            
            SPLUNK_OS_USER=splunk (where "splunk" is your splunk username)

3. configure  splunkhelper (next section)
 - This is the **MOST ESSENTIAL** step! If you skip that or do a mistake here you will get messed up
so check twice!

3. go on with "Testing your setup" and do not forget the last chapter about "Automatic splunk> startup"!

#### Configuration (update save):

1. open */usr/local/bin/splunk* with an editor and check especially the following variables (do **NOT** change anything here!):
 - **USERCONFIG**  =======> do **NOT** change it! Remember full path for the next step.
 - **SPLUSR** ===========> do **NOT** change! If you want to change copy that variable name instead)
 - **SPLDIR** ============> do **NOT** change! If you want to change copy that variable name instead)
2. Create the file defined in *USERCONFIG* (you may need to create the directory first)
3. Copy only the variables you want to change/overwrite from */usr/local/bin/splunk* to *USERCONFIG*
4. Now you can update the splunkhelper worry-free and it will respect always your personal settings.

#### Testing your setup:

1. type "splunk status" as user **>root<**. it should look similar to this: 
        ... execution command was <splunk>
        ... executed as user <root>
        ... dropping privileges to user **<splunk>**
        splunkd is running (PID: 6535).
        splunk helpers are running (PIDs: 6536 6547 6879 7061).
            
2. type "splunk status" as user **>splunk<** (or the one you defined as *SPLUSR*) <br>it should look similar to this (no "dropping privileges" because executed by the *SPLUSR*):
		... execution command was <splunk>
		... executed as user **<splunk>**
		splunkd is running (PID: 6535).
		splunk helpers are running (PIDs: 6536 6547 6879 7061).
		
3. you should check the output of the above carefully once! If everything goes well you never need to care about this again (until the next splunkhelper update ;) ).

## (Optional) Undestroyable splunk> service/boot:

If you like you can also ensure that even a "*service splunk restart/stop/start*" will be immutable by following this guide:

1. if you already have the init.d script installed skip this step and go to step 2.<br>
    You need to enable the init.d script *without* the splunkhelper cmds and as user **>root<**:
        
        #> /opt/splunk/bin/splunk enable boot-start -user splunk
        (where "/opt/splunk/" is your splunk installation path and "-user <splunk>" is your splunk username)
       
2. Afterwards open the init.d script and change all occurences of the original path with the splunkhelper path:
            #> vim /etc/init.d/splunk
            /opt/splunk/ --> /usr/local/
            e.g.:
            "/opt/splunk/bin/splunk" start ..... --> "/usr/local/bin/splunk" start ...
            
            or more easily use this single sed line:
            #> sed -i s#/opt/splunk/bin#/usr/local/bin#g /etc/init.d/splunk
  
## Updating:
      
### Updating (the EASY bulletproof way):

Once you have splunkhelper installed you can simply use the amazing *self-update function* coming with splunkhelper!
    
To do so simply execute:
- **"splunk --helperupdate"** and you're done!

You can do more stuff like the same easy update - but **without internet access**!<br>
Or you can update the developer edition instead of the master one etc etc.<br>
Check all your options with:
- **"splunk --help"**

### Updating (manually):

Sames as installing so check the install guide :)