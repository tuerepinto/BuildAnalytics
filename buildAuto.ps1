$Dir = get-childItem C:\Localiza -Recurse  
$List = $Dir | Where-Object {$_.extension -eq ".sln"} 
$List |Format-Table fullname |out-file C:\Log\sln.txt

$text = Get-Content -Path C:\log\sln.txt

foreach($item in $text)
{
    $NameSln = $item.replace('.sln','.log');  
    dotnet clean $item; dotnet clean --configuration $item; 
    dotnet restore $item; dotnet build /flp:v=diag /flp:logfile=$NameSln.log $item 
}

