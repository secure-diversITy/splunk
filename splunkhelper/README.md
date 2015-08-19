## Description

   Have you ever started splunk> as the wrong user? Oh well if you HAVE you know what I
   mean. This helper here exists to avoid those forever! 
   Just configure this helper as described in "Install" and begin using splunk> "worry-free".

  - Never worry about doing splunk> related commands with the correct user!
  - No need to switch from user >root< to your splunk user 

    Since splunk> v6.1.1 a Variable SPLUNK_OS_USER exists which is doing more or less the same
    but it doesn't work in the same manner and comes without the command shortcuts of course.
    
    Setting this Variable is nevertheless a good idea just as a fallback if something goes wrong
    (see install for the details).

## Usage:

   It is recommended to install this script in /usr/bin and name it "splunk". This 
   way wherever you are you can simply type "splunk" or one of the shortcut commands
   and don't care about using the correct user.

- "splunk" can use all arguments like with /opt/splunk/bin/splunk
- execute one of the shortcut commands to do a quick action as explained in the next chapter

## Command shortcuts:

       splunk                  --      Provides direct access to splunk binary
       splunkrestart           --      Restarts splunk
       splunkwebrestart        --      Restarts splunk web interface
       splunkdebug             --      Executes btool debug check
       splunkstop              --      Stops splunk
       splunkstart             --      Starts splunk
       splunkstatus            --      Status of splunk and helper processes

## Install:

	1) move the script "usr-bin-splunk" to "/usr/bin" , name it "splunk" and make it executable to everyone!
		#> mv /tmp/usr-bin-splunk /usr/bin/splunk
		#> chmod +x /usr/bin/splunk
		
	2) check the user vars within this script >SPLUSR< and >SPLDIR< to match your setup!!!
	   This is the MOST ESSENTIAL step. If you do a mistake here you will get messed up so check twice!
	   
	3) copy the following 1 liner (you may need to scroll to see it fully) 
	   and paste in the CLI as user >root< :
	ln -s /usr/bin/splunk /usr/bin/splunkrestart;ln -s /usr/bin/splunk /usr/bin/splunkwebrestart;ln -s /usr/bin/splunk /usr/bin/splunkdebug;ln -s /usr/bin/splunk /usr/bin/splunkstop;ln -s /usr/bin/splunk /usr/bin/splunkstart;ln -s /usr/bin/splunk /usr/bin/splunkstatus
	
	4) test it by going away from /usr/bin and type "splunk status" (or "splunkstatus") as user >root<
	   it should look similar to this:
		... execution command was <splunk>
		... executed as user <root>
		... dropping privileges to user <splunk>
		splunkd is running (PID: 6535).
		splunk helpers are running (PIDs: 6536 6547 6879 7061).
		
	5) type "splunk status" (or "splunkstatus") as user <splunk> (the one you defined as SPLUSR)
	   it should look similar to this:
		... execution command was <splunk>
		... executed as user <splunk>
		splunkd is running (PID: 6535).
		splunk helpers are running (PIDs: 6536 6547 6879 7061).
		
	6) you should check the output carefully once that everything goes well but then
	   you never need to care about again ;)
       
    7) Automatic splunk> start by init.d: You need to enable the init.d script *without* the splunkhelper cmds and as user <root>:
            #> /opt/splunk/bin/splunk enable boot-start -user splunk
            (where "/opt/splunk/" is your splunk installation path)
       
       Afterwards open the init.d script and change all occurences of the path:
            #> vim /etc/init.d/splunk
            /opt/splunk/ --> /usr/
            e.g.:
            "/opt/splunk/bin/splunk" start ..... --> "/usr/bin/splunk" start ...
    
    8) if splunk version >= 6.1.1: Set/Check the fallback splunk user variable:
            (splunk)$> vim /opt/splunk/etc/splunk-launch.conf
            
            SPLUNK_OS_USER=splunk (where "splunk" is your splunk username)
            
        That variable should be set already correctly by step 7 but checking it doesn't hurt right?!
        If that variable is set and you forget step 7 or overwrite the init.d script by accident
        it will not destroy anything 'cause of this variable here.
        