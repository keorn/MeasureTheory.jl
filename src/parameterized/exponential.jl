
# Exponential distribution

export Exponential

@parameterized Exponential(β) ≃ Lebesgue(ℝ₊)


@kwstruct Exponential()

function logdensity(d::Exponential{()} , x)
    return -x
end

Base.rand(rng::AbstractRNG, T::Type, μ::Exponential{()}) = randexp(rng,T)

TV.as(::Exponential) = asℝ₊


##########################
# Scale β

@kwstruct Exponential(β)

function Base.rand(rng::AbstractRNG, T::Type, d::Exponential{(:β,)})
    randexp(rng, T) * d.β
end

function logdensity(d::Exponential{(:β,)}, x)
    z = x / d.β
    return logdensity(Exponential(), z) - log(d.β)
end

distproxy(d::Exponential{(:β,)}) = Dists.Exponential(d.β)

asparams(::Type{<:Exponential}, ::Val{:β}) = asℝ₊

##########################
# Log-Scale logβ


@kwstruct Exponential(logβ)

function Base.rand(rng::AbstractRNG, T::Type, d::Exponential{(:logβ,)})
    randexp(rng, T) * exp(d.logβ)
end

function logdensity(d::Exponential{(:logβ,)}, x)
    z = x * exp(-d.logβ)
    return logdensity(Exponential(), z) - d.logβ
end

distproxy(d::Exponential{(:logβ,)}) = Dists.Exponential(exp(d.logβ))

asparams(::Type{<:Exponential}, ::Val{:logβ}) = asℝ




##########################
# Rate λ

@kwstruct Exponential(λ)

function Base.rand(rng::AbstractRNG, T::Type, d::Exponential{(:λ,)})
    randexp(rng, T) / d.λ
end

function logdensity(d::Exponential{(:λ,)}, x)
    z = x * d.λ
    return logdensity(Exponential(), z) + log(d.λ)
end

distproxy(d::Exponential{(:λ,)}) = Dists.Exponential(1/d.λ)

asparams(::Type{<:Exponential}, ::Val{:λ}) = asℝ₊

##########################
# Log-Rate logλ


@kwstruct Exponential(logλ)

function Base.rand(rng::AbstractRNG, T::Type, d::Exponential{(:logλ,)})
    randexp(rng, T) * exp(-d.logλ)
end

function logdensity(d::Exponential{(:logλ,)}, x)
    z = x * exp(d.logλ)
    return logdensity(Exponential(), z) + d.logλ
end

distproxy(d::Exponential{(:logλ,)}) = Dists.Exponential(exp(-d.logλ))

asparams(::Type{<:Exponential}, ::Val{:logλ}) = asℝ
