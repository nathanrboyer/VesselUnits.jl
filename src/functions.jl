"""
    cylinder_volume(D, L)
    cylinder_volume(; D, L)

Compute the volume of a cylinder with diameter `D` and length `L`.

If used with keyword arguments, argument order doesn't matter, e.g. `cylinder_volume(L=10, D=3)`.
"""
cylinder_volume(D, L) = pi * D^2 / 4 * L
cylinder_volume(; D, L) = cylinder_volume(D, L)

"""
    shell_volume(OD, ID, L)
    shell_volume(; OD, ID, L)

Compute the volume of a cylindrical shell with outer diameter `OD`, inner diameter `ID`, and length `L`.

If used with keyword arguments, argument order doesn't matter, e.g. `shell_volume(L=10, ID=3, OD=7)`.
"""
shell_volume(OD, ID, L) = cylinder_volume(OD, L) - cylinder_volume(ID, L)
shell_volume(; OD, ID, L) = shell_volume(OD, ID, L)

const DIGITS_DEFAULT = 3
"""
    percent_error(x1, x2; ref = :avg, digits = $DIGITS_DEFAULT)
    percent_error(x1, x2, ref; digits = $DIGITS_DEFAULT)
    percent_error(x1, x2, ref, digits)

Compute the percent error between values `x1` and `x2` relative to reference value `ref`.

`ref` and `digits` are optional arguments that may be input by position or keyword.

# Arguments
- `x1`: first value
- `x2`: second value
- `ref`: reference value
    - `:first`: compute error relative to `x1`
    - `:second`: compute error relative to `x2`
    - `:min`: compute error relative to the smaller of `x1` and `x2` (largest error)
    - `:max`: compute error relative to the larger of `x1` and `x2` (smallest error)
    - `:avg`: compute error relative to the average of `x1` and `x2` (intermediate error)
- `digits`: round resultant percent error to this many digits
"""
function percent_error(x1, x2; ref=:avg, digits=DIGITS_DEFAULT)
    if ref in (:first, :x1)
        err = (x2 - x1) / x1
    elseif ref in (:second, :x2)
        err = (x1 - x2) / x2
    elseif ref in (:min, :minimum)
        err = abs(x2 - x1) / min(x1, x2)
    elseif ref in (:max, :maximum)
        err = abs(x2 - x1) / max(x1, x2)
    elseif ref in (:avg, :average)
        avg = (x1 + x2) / 2
        err = abs(x2 - x1) / avg
    else
        throw(ArgumentError("`error` function undefined for `ref` value `$ref`"))
    end
    return round(u"%", err; digits)
end
percent_error(x1, x2, ref; digits=DIGITS_DEFAULT) = percent_error(x1, x2; ref, digits)  # 3 arg method
percent_error(x1, x2, ref, digits) = percent_error(x1, x2; ref, digits)                 # 4 arg method
