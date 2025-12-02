## -- PRIVATE FUNCTIONS BELOW HERE ------------------------------------------------------------------------------ #
function _jld2(path::String)::Dict{String,Any}
    return load(path);
end
# -- PRIVATE FUNCTIONS ABOVE HERE ------------------------------------------------------------------------------ #

# -- PUBLIC FUNCTIONS BELOW HERE ------------------------------------------------------------------------------- #

"""
    MyTestingMarketDataSet() -> Dict{String, DataFrame}

Load the components of the SP500 Daily open, high, low, close (OHLC) dataset as a dictionary of DataFrames.
This data was provided by [Polygon.io](https://polygon.io/) and covers the period from January 3, 2025, to the current date (it is updated periodically).

"""
MyTestingMarketDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2025-to-11-18-2025.jld2"));

"""
    MyTrainingMarketDataSet() -> Dict{String, DataFrame}

Load the components of the SP500 Daily open, high, low, close (OHLC) dataset as a dictionary of DataFrames.
This data was provided by [Polygon.io](https://polygon.io/) and covers the period from January 3, 2014, to December 31, 2024.

"""
MyTrainingMarketDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2014-to-12-31-2024.jld2"));

"""
    MyTickerPickerBanditModelResults() -> Dict{String, Any}

Load the ticker-picker bandit model results computed in the `Setup-L14a-Example-RiskAware-BBBP-Ticker-Picker-Fall-2025.ipynb` notebook.
"""
function MyTickerPickerBanditModelResults(;mood::Symbol = :neutral)::Dict{String, Any}
    # determine file name based on mood
    filename = if (mood == :optimistic)
        "Ticker-Picker-Preferences-Optimistic-Fall-2025.jld2"
    elseif (mood == :pessimistic)
        "Ticker-Picker-Preferences-Pessimistic-Fall-2025.jld2"
    elseif (mood == :neutral)
        "Ticker-Picker-Preferences-Neutral-Fall-2025.jld2"
    else
        error("Invalid mood specified: $mood. Valid options are :optimistic, :neutral, :pessimistic.")
    end

    path = joinpath(_PATH_TO_DATA, filename)

    # Provide a clearer error message if the expected file is missing and show available files
    if !isfile(path)
        available = readdir(_PATH_TO_DATA)
        error_msg = "Ticker-picker preferences file not found: $(path)\n"
        error_msg *= "Available files in data directory: \n"
        for f in available
            error_msg *= "  - $(f)\n"
        end
        error_msg *= "\nTo create the expected preferences files, run the `Setup-L14a-Example-RiskAware-BBBP-Ticker-Picker-Fall-2025.ipynb` notebook or place the JLD2 files into the data directory."
        error(error_msg)
    end

    return _jld2(path)
end
# -- PUBLIC FUNCTIONS ABOVE HERE ------------------------------------------------------------------------------ #