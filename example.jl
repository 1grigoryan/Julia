### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ a6648952-5a6d-11eb-2c81-99d1514983c0
using CSV, Econometrics, RDatasets, GLMNet, DataFrames, Statistics, StatsBase, GLM

# ╔═╡ ce00b61e-5a71-11eb-2f3c-a39c701bc9a2
md"### Регуляризация"

# ╔═╡ d65fc5c2-6215-11eb-3f82-2de3ce633b93
md"### Регуляризация"

# ╔═╡ 093d42ea-5a72-11eb-19b1-6b0abb122099
auto = dataset("ISLR", "Auto")

# ╔═╡ 17994b30-6216-11eb-05de-d1e8fef75c42
begin
	auto["Cylinders_sq"] = auto["Cylinders"].^2;
	auto["Displacement_sq"] = auto["Displacement"].^2;
	auto["Horsepower_sq"] = auto["Horsepower"].^2;
	auto["Weight_sq"] = auto["Weight"].^2;
	auto["Acceleration_sq"] = auto["Acceleration"].^2;
end

# ╔═╡ 22840156-5a72-11eb-0e57-ff3178e5ee6f
describe(auto) #содержательная статистика

# ╔═╡ 453374cc-5a72-11eb-333f-f9b25d510984
model_a = fit(EconometricModel, @formula(log(1 + MPG) ~ Displacement + Horsepower + Weight + Acceleration + Year + Displacement_sq + Acceleration_sq), auto)

# ╔═╡ 30a97e08-62d9-11eb-0c4d-479463f2ab72
model_a_glm = glm(@formula(log(1 + MPG) ~ Displacement + Horsepower + Weight + Acceleration + Year + Displacement_sq + Acceleration_sq), auto, Normal())

# ╔═╡ 7318d1f4-62db-11eb-2419-1f90695f64f9
md"### GLMNet"

# ╔═╡ b77d7afc-61e1-11eb-0e0f-55c1b299680c
X = hcat(Array(auto[:, 3:7]), Array(auto[:, 11:14]))

# ╔═╡ c2e747e2-61e1-11eb-3ac5-d7bc26e4b98e
y = Array(auto[:, 1])

# ╔═╡ c6253aa6-61e4-11eb-214c-412220911078
lasso = glmnetcv(X, y, alpha = 1)

# ╔═╡ d35f5116-61ee-11eb-1d2d-a70a56e4f5c4
function r2(model, X, y)
	pred = GLMNet.predict(model, X);
	RSS = sum((pred - y).^2);
	TSS = sum((y .- mean(y)).^2);
	(TSS - RSS)/TSS;
end

# ╔═╡ fdb7edfa-6212-11eb-07e4-19667961840b
r2(lasso, X, y)

# ╔═╡ 17f4ee00-62d8-11eb-03f6-e78344c2183b
ridge = glmnetcv(X, y, alpha = 0)

# ╔═╡ 1fe3177c-62d8-11eb-0193-cb9420f3f4c7
r2(ridge, X, y)

# ╔═╡ a452a384-5a71-11eb-1b53-87f3954a0150
md"### Markdown"

# ╔═╡ 11bab1ec-5a71-11eb-2034-653ec8b55628
md"md используем для обозначения типа ячейки markdown, то есть пишем текст, который в кавычках"

# ╔═╡ d5485590-5a6e-11eb-07cd-7b56150eca5c
md"
!!! note
    Это чтобы все (!) видели, тут вторая строка неприкасаема (но мне не нравится надпись Note)
"

# ╔═╡ 66ef399a-5a70-11eb-2450-7367eb5110b3
md"
Это обычный текст
"

# ╔═╡ dc85011c-5a70-11eb-0a77-0dcc2885e18c
md"**выделенный текст**"

# ╔═╡ 390f49ec-5a71-11eb-15b8-fd584d94b7f5
md"*курсив*"

# ╔═╡ 656842fa-5a71-11eb-11cd-c3c4b7ca0edd
md"`текст на фоне`"

# ╔═╡ 837a9c0c-5a71-11eb-16fd-15ac9102d46b
md"Еще тут можно в ``\LaTeX``

$$\dfrac{d^2z}{dt^2} = t^z + \sin{t}$$"

# ╔═╡ ed88cd9e-5a71-11eb-245f-69bbe469d355
md"Вроде бы это все, что нужно, но если что, есть вот такой [сайтик](https://docs.julialang.org/en/v1/stdlib/Markdown/)"

# ╔═╡ Cell order:
# ╠═ce00b61e-5a71-11eb-2f3c-a39c701bc9a2
# ╟─d65fc5c2-6215-11eb-3f82-2de3ce633b93
# ╠═a6648952-5a6d-11eb-2c81-99d1514983c0
# ╠═093d42ea-5a72-11eb-19b1-6b0abb122099
# ╠═17994b30-6216-11eb-05de-d1e8fef75c42
# ╠═22840156-5a72-11eb-0e57-ff3178e5ee6f
# ╠═453374cc-5a72-11eb-333f-f9b25d510984
# ╠═30a97e08-62d9-11eb-0c4d-479463f2ab72
# ╟─7318d1f4-62db-11eb-2419-1f90695f64f9
# ╠═b77d7afc-61e1-11eb-0e0f-55c1b299680c
# ╠═c2e747e2-61e1-11eb-3ac5-d7bc26e4b98e
# ╠═c6253aa6-61e4-11eb-214c-412220911078
# ╠═d35f5116-61ee-11eb-1d2d-a70a56e4f5c4
# ╠═fdb7edfa-6212-11eb-07e4-19667961840b
# ╠═17f4ee00-62d8-11eb-03f6-e78344c2183b
# ╠═1fe3177c-62d8-11eb-0193-cb9420f3f4c7
# ╟─a452a384-5a71-11eb-1b53-87f3954a0150
# ╠═11bab1ec-5a71-11eb-2034-653ec8b55628
# ╠═d5485590-5a6e-11eb-07cd-7b56150eca5c
# ╠═66ef399a-5a70-11eb-2450-7367eb5110b3
# ╠═dc85011c-5a70-11eb-0a77-0dcc2885e18c
# ╠═390f49ec-5a71-11eb-15b8-fd584d94b7f5
# ╠═656842fa-5a71-11eb-11cd-c3c4b7ca0edd
# ╠═837a9c0c-5a71-11eb-16fd-15ac9102d46b
# ╠═ed88cd9e-5a71-11eb-245f-69bbe469d355
