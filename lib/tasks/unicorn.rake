UNICORN_PID_FILE = "/app/esal/web/esal.net/tmp/unicorn.pid"

namespace :unicorn do
  desc "Start unicorn for development env."
  task(:start) {
    config = Rails.root + "config/unicorn.rb"
    env = ENV['RAILS_ENV'] || 'production'
    sh "bundle exec unicorn_rails -c #{config} -E #{env} -D"
  }

  desc "Stop unicorn"
  task(:stop) { unicorn_signal :QUIT }

  desc "Restart unicorn with USR2"
  task(:restart) { unicorn_signal :USR2 }

  desc "Increment number of worker processes"
  task(:increment) { unicorn_signal :TTIN }

  desc "Decrement number of worker processes"
  task(:decrement) { unicorn_signal :TTOU }

  desc "Unicorn pstree (depends on pstree command)"
  task(:pstree) do
    sh "pstree '#{unicorn_pid}'"
  end

  def unicorn_signal signal
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    begin
      File.read(UNICORN_PID_FILE).to_i
    rescue Errno::ENOENT
      raise "Unicorn doesn't seem to be running"
    end
  end
end
