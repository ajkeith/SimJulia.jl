using SimJulia

type StoreObject
  i :: Int
end

function consumer(sim::Simulation, sto::Store)
  for i = 1:10
    yield(Timeout(sim, rand()))
    println("$(now(sim)), consumer is demanding object")
    obj = yield(Get(sto))
    println("$(now(sim)), consumer is being served with object $(obj.i)")
  end
end

function producer(sim::Simulation, sto::Store)
  for i = 1:10
    println("$(now(sim)), producer is offering object $i")
    yield(Put(sto, StoreObject(i)))
    println("$(now(sim)), producer is being served")
    yield(Timeout(sim, 2*rand()))
  end
end

sim = Simulation()
sto = Store(StoreObject, sim)
@Process consumer(sim, sto)
@Process producer(sim, sto)
run(sim)
