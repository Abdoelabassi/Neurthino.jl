struct Layer
    name::AbstractString
    r_min
    r_max
    density::Polynomial
end


struct EarthModel
    layers::Vector{Layer}
end


PREM = EarthModel(
    [
        Layer("Inner Core", 0.0, 1221.5, Polynomial([13.0885, 0.0, -8.8381])),
        Layer("Outer Core", 1221.5, 3480.0, Polynomial([12.5815, -1.2638, -3.6426, -5.5281])),
        Layer("Lower Mantle", 3480.0, 5701.0, Polynomial([7.9565, -6.4761, 5.5283, -3.0807])),
        Layer("Transition Zone 1", 5701.0, 5771.0, Polynomial([5.3197, -1.4836])),
        Layer("Transition Zone 2", 5771.0, 5971.0, Polynomial([11.2494, -8.0298])),
        Layer("Transition Zone 3", 5971.0, 6151.0, Polynomial([7.1089, -3.8045])),
        Layer("LVZ", 6151.0, 6291.0, Polynomial([2.6910, 0.6924])),
        Layer("LID", 6291.0, 6346.6, Polynomial([2.6910, 0.6924])),
        Layer("Crust 1", 6346.6, 6356.0, Polynomial([2.9])),
        Layer("Crust 2", 6356.0, 6368.0, Polynomial([2.6])),
        Layer("Ocean", 6368.0, 6371.0, Polynomial([1.020]))
    ]
)


function (m::EarthModel)(r)
    for layer ∈ m.layers
        if r < layer.r_max && r >= layer.r_min
            return layer.density(r / m.layers[end].r_max)
        end
    end
end
