# frozen_string_literal: true

require 'thor'

module Bjt
  class Cli < Thor
    package_name 'bjt'

    desc 'p', 'Jump To Gems Repos'
    def p(package)
      Bjt::Jumper.new(:p, package).jump
    end

    desc 'g', 'Jump To Github or Gitlab'
    def g(package)
      Bjt::Jumper.new(:g, package).jump
    end

    desc 'h', 'Jump To Homepage'
    def h(package)
      Bjt::Jumper.new(:h, package).jump
    end

    desc 's', 'Jump To Source'
    def s(package)
      Bjt::Jumper.new(:s, package).jump
    end

    desc 'r', 'Jump To Releases'
    def r(package)
      Bjt::Jumper.new(:r, package).jump
    end

    desc 'd', 'Jump To Library RDocs'
    def d(package)
      Bjt::Jumper.new(:d, package).jump
    end

    desc 'l', 'Jump To Local Dir'
    def l(package)
      Bjt::Jumper.new(:l, package).jump
    end

    def self.exit_on_failure?
      true
    end
  end
end
