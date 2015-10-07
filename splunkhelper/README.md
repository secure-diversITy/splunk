## Description

   Have you ever started splunk> as the wrong user? Oh well if you *HAVE* - you know what I
   mean. This helper here exists to avoid this problem forever! 
   Just configure this helper as described in "Install" and begin using splunk> "worry-free".

   Note:   
   Since splunk> v6.1.1 a Variable *SPLUNK_OS_USER* exists which is doing more or less the same
   but not in the complete same manner and it comes without the command shortcuts, of course.
   Setting this Variable is nevertheless a good idea - at least as a fallback if something goes wrong
   (see install for the details). Using that variable + this helper will make your splunk commands
   as much immutable as possible!

- Never worry about doing splunk> related commands with the correct user
- No need to switch from user >root< to your splunk user (privileges gets dropped automagically)
- Ease up your life by entering simple shortcuts instead of non-rememberable arguments
- Simply execute splunk commands regardless in which path you currently are in

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

    1) as root or while using sudo:
        #> make install
    
    2) check the user vars within /usr/local/bin/splunk:
        --> >SPLUSR< and >SPLDIR< have to match your setup!!!
        This is the MOST ESSENTIAL step.
        If you skip that or do a mistake here you will get messed up
        so check twice!
        
    3) go on with "Testing your setup" and do not forget the last chapter about "Automatic splunk> startup"!

#### Configuration (update save):

    open /usr/local/bin/splunk with an editor and check the variable USERCONFIG.
    Do NOT change anything here!
    If you really need to you could change the path and filename of USERCONFIG but why?
    
    Create the file defined in USERCONFIG
    Copy only the variables you want to change/overwrite from /usr/local/bin/splunk to USERCONFIG
    
    Now you can update the splunkhelper and it will respect always your personal settings.

#### Testing your setup:

	1) test it by going away from /usr/local/bin and type "splunk status" (or "splunkstatus") as user >root<
	   it should look similar to this:
		... execution command was <splunk>
		... executed as user **<root>**
		... dropping privileges to user **<splunk>**
		splunkd is running (PID: 6535).
		splunk helpers are running (PIDs: 6536 6547 6879 7061).
		
	2) type "splunk status" (or "splunkstatus") as user <splunk> (the one you defined as SPLUSR)
	   it should look similar to this (no "dropping privileges" because executed by the SPLUSR):
		... execution command was <splunk>
		... executed as user **<splunk>**
		splunkd is running (PID: 6535).
		splunk helpers are running (PIDs: 6536 6547 6879 7061).
		
	3) you should check the output carefully once that everything goes well but then
	   you never need to care about again ;)

## Automatic splunk> startup when booting:

    1) if you already have the init.d script installed skip this step and go to step 2.
       Automatic splunk> start by init.d: You need to enable the init.d script *without* the splunkhelper cmds and as user <root>:
            #> /opt/splunk/bin/splunk enable boot-start -user splunk
            (where "/opt/splunk/" is your splunk installation path)
       
    2)   Afterwards open the init.d script and change all occurences of the path:
            #> vim /etc/init.d/splunk
            /opt/splunk/ --> /usr/local/
            e.g.:
            "/opt/splunk/bin/splunk" start ..... --> "/usr/local/bin/splunk" start ...
            
            or more easily use this single sed line:
            #> sed -i s#/opt/splunk/bin#/usr/local/bin#g /etc/init.d/splunk
    
    3) if splunk version >= 6.1.1: Set/Check the fallback splunk user variable:
            (splunk)$> vim /opt/splunk/etc/splunk-launch.conf
            
            SPLUNK_OS_USER=splunk (where "splunk" is your splunk username)
            
        That variable should be set already correctly by step 1 but checking it doesn't hurt right?!
        If that variable is set and you forget step 2 or overwrite the init.d script by accident
        it will not destroy anything 'cause of this variable here.
        
## Updating (the EASY bulletproof way):

    Once you have splunkhelper installed you can simply use the self-update function coming with splunkhelper!
    
    To do so simply execute **"splunk --helperupdate"** and you be done. You can do more stuff check them out with
    **"splunk --help"**
