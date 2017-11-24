class SnackBox
  SNACK_BOX_DATA = {
    1 => {
      "bone" => {
        "info" => "Phoenician rawhide",
        "tastiness" => 20
      },
      "kibble" => {
        "info" => "Delicately braised hamhocks",
        "tastiness" => 33
      },
      "treat" => {
        "info" => "Chewy dental sticks",
        "tastiness" => 40
      }
    },
    2 => {
      "bone" => {
        "info" => "An old dirty bone",
        "tastiness" => 2
      },
      "kibble" => {
        "info" => "Kale clusters",
        "tastiness" => 1
      },
      "treat" => {
        "info" => "Bacon",
        "tastiness" => 80
      }
    },
    3 => {
      "bone" => {
        "info" => "A steak bone",
        "tastiness" => 64
      },
      "kibble" => {
        "info" => "Sweet Potato nibbles",
        "tastiness" => 45
      },
      "treat" => {
        "info" => "Chicken bits",
        "tastiness" => 75
      }
    }
  }
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def get_bone_info(box_id)
    @data[box_id]["bone"]["info"]
  end

  def get_bone_tastiness(box_id)
    @data[box_id]["bone"]["tastiness"]
  end

  def get_kibble_info(box_id)
    @data[box_id]["kibble"]["info"]
  end

  def get_kibble_tastiness(box_id)
    @data[box_id]["kibble"]["tastiness"]
  end

  def get_treat_info(box_id)
    @data[box_id]["treat"]["info"]
  end

  def get_treat_tastiness(box_id)
    @data[box_id]["treat"]["tastiness"]
  end
end

class CorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def bone
    info = @snack_box.get_bone_info(@box_id)
    tastiness = @snack_box.get_bone_tastiness(@box_id)
    result = "Bone: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @snack_box.get_kibble_info(@box_id)
    tastiness = @snack_box.get_kibble_tastiness(@box_id)
    result = "Kibble: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def treat
    info = @snack_box.get_treat_info(@box_id)
    tastiness = @snack_box.get_treat_tastiness(@box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end
end

class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id

    snack_box.methods.grep(/^get_(.*)_info$/) do
      MetaCorgiSnacks.define_snack(Regexp.last_match(1))
    end
  end

  # ~ one method if @snack_box is just the hash
  # def method_missing(name, *args)
  #   if name.to_s.start_with?("get_")
  #     underscore_1 = name.to_s.index("_")
  #     underscore_2 = name.to_s.rindex("_")
  #     super if underscore_2.nil?
  #
  #     treat = name.to_s[underscore_1 + 1...underscore_2]
  #     query = name.to_s[underscore_2 + 1..-1]
  #
  #     @snack_box[@box_id][treat][query]
  #   elsif @snack_box[@box_id].key?(name.to_s)
  #     query = @snack_box[@box_id][name.to_s]
  #     "#{'* ' if query["tastiness"] > 30}#{name.capitalize}: #{query["info"]}: #{query["tastiness"]}"
  #   else
  #     super
  #   end
  # end

  # ~ 1. use `send` to refactor `bone`, `kibble`, `treat` from `CorgiSnacks`
  # def method_missing(name, *args)
  #   info = @snack_box.send("get_#{name}_info", @box_id)
  #   tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
  #   result = "#{name.capitalize}: #{info}: #{tastiness} "
  #   tastiness > 30 ? "* #{result}" : result
  # end

  # ~ 2. refactor above with dynamic dispatch
  # ~ throws an error (unmodified `method_missing`) if `name` wasn't
  #   defined in `initialize`
  def self.define_snack(name)
    define_method(name) do
      info = @snack_box.send("get_#{name}_info", @box_id)
      tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
      result = "#{name.capitalize}: #{info}: #{tastiness} "
      tastiness > 30 ? "* #{result}" : result
    end
  end
end
