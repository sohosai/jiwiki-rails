class EnablePgroonga < ActiveRecord::Migration
  def change
    enable_extension('pgroonga')
  end
end
