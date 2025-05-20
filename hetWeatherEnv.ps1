# Ladda nycklar från .env
Get-Content .env | ForEach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
        $name, $value = $matches[1], $matches[2]
        if (-not [System.Environment]::GetEnvironmentVariable($name)) {
            [System.Environment]::SetEnvironmentVariable($name, $value)
        }
    }
}

function Get-Weather {
    param([string]$city)

    $key = $env:WEATHER_KEY
    $url = "http://api.weatherapi.com/v1/current.json?key=$key&q=$city"

    $response = Invoke-RestMethod -Uri $url
    return $response.current.temp_c
}

# Anropa funktionen
Get-Weather -city "Öland"