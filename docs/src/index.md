# SimJulia.jl

SimJulia is a combined continuous time / discrete event process oriented simulation framework written in [Julia](http://julialang.org/) inspired by the Simula library [DISCO](http://www.akira.ruc.dk/~keld/research/DISCO/) and the Python library [SimPy](https://simpy.readthedocs.io/).

Its event dispatcher is based on a **Task**. This is a control flow feature in Julia that allows comPutations to be suspended and resumed in a flexible manner. **Processes** in SimJulia are defined by functions yielding **Events**. SimJulia also provides three types of shared resources to model limited capacity congestion points: **Resources**, **Containers** and **Stores**. The API is modeled after the SimPy API but using some specific Julia semantics.

A short example simulating two clocks ticking in different time intervals looks like this:
```@example
using SimJulia

function clock(sim::Simulation, name::String, tick::Float64)
  while true
    println("$name, $(now(sim))")
    yield(Timeout(sim, tick))
  end
end

sim = Simulation()
Process(clock, sim, "fast", 0.5)
Process(clock, sim, "slow", 1.0)
run(sim, 2.0)
```

The continuous time simulation framework is still under development and is based on a quantized state system solver that naturally integrates in the discrete event framework. Events can be triggered on **Zerocrossings** of functions depending on the continuous **Variables** described by a system of differential equations.

SimJulia contains tutorials, in-depth documentation, and a large number of examples. Most of the tutorials and the examples are borrowed from the SimPy distribution to allow a direct comparison and an easy migration path for users. The examples of continuous time simulation are heavily influenced by the examples in the DISCO library.

New ideas or interesting examples are always welcome and can be submitted as an issue or a pull Request on GitHub.

### Authors

- [Ben Lauwens](http://www.rma.ac.be/), Royal Military Academy, Brussels, Belgium

### License

SimJulia is licensed under the [MIT "Expat" license](https://github.com/BenLauwens/SimJulia.jl/blob/master/LICENSE.md).