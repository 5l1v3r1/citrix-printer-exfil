# The client running in a PowerShell Session on the Citrix endpoint
# by DK & MZ
   
   $all_printers = get-WmiObject -class Win32_printer
   $len = (get-WmiObject -class Win32_printer).length
   $myPrinter = "";
   for($i = 0;$i -lt $len;$i++)
   {
      if($all_printers[$i].location -eq "red")
           {
              $myPrinter = $i;
           }
   }
   $currentName = $all_printers[$myPrinter].Name.Split(" ")[0]
   $name = $currentName
   $output = $currentName
   while($currentName -ne "red")
   {
           write-host "waiting... $currentName"
           [System.Threading.Thread]::Sleep(3000);
           $all_printers = get-WmiObject -class Win32_printer
           for($i = 0;$i -lt $len;$i++)
           {
              if($all_printers[$i].location -eq "red")
                   {
                      $myPrinter = $i;
                      write-host $all_printers[$myPrinter].Name.Split(" ")[0];
                   }
           }
           $currentName = $all_printers[$myPrinter].Name.Split(" ")[0]
   }
   write-host "Starting!!"
   while($currentName -ne "END")
   {
           if($currentName -ne $name)
           {
                   if($all_printers.length -eq $len)
                   {
                           if($currentName -ne "red")
                                   {
                                    $name = $currentName;
                                    write-host "Appending $currentName"
                                    $output+=$currentName;
                                   }        
                   }
           }
           $all_printers = get-WmiObject -class Win32_printer
           for($i = 0;$i -lt $len;$i++)
           {
              if($all_printers[$i].location -eq "red")
                   {
                      $myPrinter = $i;
                      #write-host $all_printers[$myPrinter].Name.Split(" ")[0];
                   }
           }
           $currentName = $all_printers[$myPrinter].Name.Split(" ")[0]
   }
   $output = $output.substring(3);
   write-host "generating file out of $output"
   New-Item -Name "file.txt" -type file -value $output
   $file = [System.Convert]::FromBase64String($output);
   [System.IO.File]::WriteAllBytes("\\127.0.0.1\d$\red\file64.txt",$file);
   write-host "DONE!"
