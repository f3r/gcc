module ActiveRecord
  module Stats #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      # TODO: Turn this into a gem
      def histo_counts(opts = {})
        opts = {
          :date_field => :created_at,
          :table_name => self.table_name,
          :cummulative => false
        }.merge(opts)

        start_date = opts[:start_date] # Optional
        end_date = opts[:end_date] # Optional

        conditions = "1 = 1"

        if start_date
          conditions << " AND date(#{opts[:date_field]}) >= '#{start_date}'"
        end

        if end_date
          condtions" AND date(#{opts[:date_field]}) <= '#{end_date}'"
        end

        if opts[:extra_conditions]
          conditions << " AND #{opts[:extra_conditions]}"
        end

        query = %{
          SELECT date(#{opts[:date_field]}) day, count(1) q
          FROM #{opts[:table_name]}
          WHERE #{conditions}
        }
        query << " GROUP BY day"
        query << " ORDER BY day"

        stats = ActiveRecord::Base.connection.execute(query)

        # Add option for cummulative
        matrix_for_result_set(stats.to_a, start_date, end_date, opts[:cummulative])
      end

      private

      def matrix_for_result_set(stats, start_date, end_date, cummulative = false)

        if stats.empty?
          return []
        end

        # Convert result set to date => value hash
        data = {}
        stats.each do |date, value|
          data[date] = value
        end

        # Generate matrix with data for all the days in the date range
        chart_data = []
        total = 0

        start_date ||= stats.first[0]
        end_date   ||= stats.last[0]

        start_date.upto(end_date).each_with_index do |date, idx|
          value = data[date] || 0
          if cummulative
            total += value
            chart_data[idx] = [date, total]
          else
            chart_data[idx] = [date, value]
          end
        end

        chart_data
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Stats)