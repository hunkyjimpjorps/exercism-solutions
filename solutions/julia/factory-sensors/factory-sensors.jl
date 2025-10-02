function humiditycheck(pct_humidity)
    pct_humidity > 70 ? throw(ErrorException("humidity check failed -- $pct_humidity% humidity exceeds 70% limit")) :
    @info "humidity level check passed: $pct_humidity%"
end

function temperaturecheck(temperature)
    isnothing(temperature) ? throw(ArgumentError("sensor is unresponsive")) :
    temperature > 500 ? throw(DomainError(temperature, "overheat condition")) :
    @info "temperature check passed: $temperature °C"
end

struct MachineError <: Exception end

function machinemonitor(pct_humidity, temperature)
    machine_error = false

    try
        humiditycheck(pct_humidity)
    catch problem
        machine_error = true
        if problem isa ErrorException
            @error "humidity level check failed: $pct_humidity%"

        end
    end

    try
        temperaturecheck(temperature)
    catch problem
        machine_error = true
        if problem isa ArgumentError
            @warn "sensor is broken"
        elseif problem isa DomainError
            @error "overheating detected: $temperature °C"
        end
    end

    if machine_error
        throw(MachineError())
    end
end
