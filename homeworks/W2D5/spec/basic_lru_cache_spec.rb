require "basic_lru_cache"

describe LRUCache do
  subject(:cache) { LRUCache.new(4) }

  context "outside class" do
    before { cache.add([1, 2, 3]) }
    before { cache.add(5) }
    before { cache.add(-5) }
    before { cache.add({ a: 1, b: 2, c: 3 }) }

    let(:cache_status) { [[1, 2, 3], 5, -5, { a: 1, b: 2, c: 3 }] }

    it "doesn't let user mutate cache" do
      cache.count << 0
      expect { cache.show << 0 }.to raise_error(NoMethodError)
      expect { cache.add("Valid") << 0 }.to raise_error(NoMethodError)
      expect { cache.show }.to output("[5, -5, {:a=>1, :b=>2, :c=>3}, \"Valid\"]\n").to_stdout
    end
  end

  it "returns correct output when duplicate added" do
    cache.add("I walk the line")
    cache.add(5)

    expect(cache.count).to eq(2)

    cache.add([1, 2, 3])
    cache.add(5)
    cache.add(-5)
    cache.add({ a: 1, b: 2, c: 3 })
    cache.add([1, 2, 3, 4])
    cache.add("I walk the line")
    cache.add(:ring_of_fire)
    cache.add("I walk the line")
    cache.add({ a: 1, b: 2, c: 3 })

    # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
    expect { cache.show }.to output("[[1, 2, 3, 4], :ring_of_fire, \"I walk the line\", {:a=>1, :b=>2, :c=>3}]\n").to_stdout
  end
end
