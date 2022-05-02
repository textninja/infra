tool "placeholder" do
  desc "Placeholder tool for later use"
  flag :what, default: "does nothing"
  def run
    puts "This tool #{what}"
  end
end
