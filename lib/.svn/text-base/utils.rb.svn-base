
def logr(s, timing = false)
  Logr.logr(s, timing) 
end

def timr(s = "")
  Logr.timr(s)
end

class Logr

  @@stack = Array.new

  def self.logr(s, timing)
    if timing
      @@stack.push([Time.now.to_f, s])
    end
    logger = Logger.new("log/parser.log", 'daily')
    logger.info "#{Time.now} - #{s}"  
  end

  def self.timr(s)
    event = @@stack.pop
    if event.nil?
      return
    end
    timing = Time.now.to_f - event[0]
    logger = Logger.new("log/performance.log", 'daily')
    logger.info "#{Time.now} - #{event[1]} (#{s}) #{timing}"
  end

end

class Time

  def to_filename
    "#{self.year.to_s.ljust(4, '0')}#{self.month.to_s.ljust(2, '0')}#{self.day.to_s.ljust(2, '0')}_#{self.hour.to_s.ljust(2, '0')}#{self.min.to_s.ljust(2, '0')}#{self.sec.to_s.ljust(2, '0')}"
  end

  def mysql
    "#{self.strftime('%Y-%m-%d %H:%m:%S')}"
  end

end

class Object
  def to_bool
    Boolean(self)
  end
end


