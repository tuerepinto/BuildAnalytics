$Dir = get-childItem C:\Localiza -Recurse;  

$List = $Dir | Where-Object {$_.Extension -eq ".sln"};
$List |Format-Table fullname |out-file C:\Log\sln.txt;

$Log = $Dir | Where-Object {$_.Extension -eq ".log"};
$Log |Format-Table fullname |Out-File C:\Log\log.txt;

$Slntext = Get-Content -Path C:\log\sln.txt;
$LogText =  Get-Content -Path C:\log\log.txt;

$NewFolder = 'C:\Log\Export\';

foreach($item in $Slntext)
{
    $NameSln = $item.replace('.sln','.log');  
    dotnet clean $item; 
    dotnet restore $item; dotnet build /flp:v=diag /flp:logfile=$NameSln $item;
}

foreach ($item in $LogText)
{ 
    $item.Replace(' .log', '');
    $item.Replace(' ', '');
    Move-Item -Path $item -Destination $NewFolder;
}
