namespace :courses do
  desc "Create initial list of courses"
  task create_initial_list: :environment do
    course_arrays.each do |course_array|
      c = Course.create(
        code: course_array[0],
        name: course_array[1],
        active: course_array[2] == "Y"
      )
      puts "#{c.code} created"
    end
  end

  def course_arrays
    [
      ['MORS-521-0', 'Advanced Negotiations', 'Y'],
      ['ACCT-444-0', 'Financial Planning for Mergers & Acquisitions', 'Y'],
      ['ACCT-520-1', 'Seminar in Empirical Capital Markets Research in Accounting', 'Y'],
      ['FINC-485-1', 'Asset Pricing I', 'Y'],
      ['FINC-486-1', 'Corporate Finance I', 'Y'],
      ['FINC-934-0', 'Asset Management Practicum II', 'Y'],
      ['FINC-944-5', 'Investment Banking Recruiting Prep', 'Y'],
      ['KPPI-452-0', 'Social Innovation: Designing for Change', 'Y'],
      ['KPPI-480-0', 'Public Economics for Business Leaders: State and Local Policy', 'Y'],
      ['MECN-450-0', 'Macroeconomics', 'Y'],
      ['MKTG-542-0', 'Research Philosophies in Marketing and Consumer Behavior', 'Y'],
      ['MKTG-560-0', 'Marketing Strategy', 'Y'],
      ['MKTG-926-5', 'Creative on Demand: Brand Management 24/7', 'Y'],
      ['MORS-424-1', 'The Individual and the Organization', 'Y'],
      ['MORS-425-2', 'Organizations In Their Environments', 'Y'],
      ['MORS-454-5', 'Creating and Managing Strategic Alliances', 'Y'],
      ['MORS-522-0', 'Economics, Social Psychology and their Experiments', 'Y'],
      ['MORS-934-0', 'Managing in Professonal Service Firms', 'Y'],
      ['OPNS-440-0', 'Designing and Managing Business Processes', 'Y'],
      ['OPNS-482-0', 'Service Operations', 'Y'],
      ['OPNS-522-0', 'Queueing Networks: Performance Analysis', 'Y'],
      ['OPNS-955-5', 'Scaling Operations: Linking Strategy and Execution', 'Y'],
      ['OPNS-980-0', 'Service Design', 'Y'],
      ['REAL-444-0', 'Real Estate Development', 'Y'],
      ['STRT-444-0', 'Healthcare Economics', 'Y'],
      ['STRT-931-5', 'Strategic Franchising', 'Y'],
      ['STRT-960-5', 'Strategic Decisions: A Guide to Making Winning Choices', 'Y'],
      ['ACCT-431-0', 'Managerial Accounting', 'Y'],
      ['ACCT-451-0', 'Financial Reporting and Analysis', 'Y'],
      ['ACCT-459-5', 'Sustainability Reporting and Analysis', 'Y'],
      ['ACCT-520-4', 'Seminar on Agency Theory and Information Economics', 'Y'],
      ['BLAW-437-0', 'Issues In Antitrust', 'Y'],
      ['BLAW-925-0', 'Mergers and Acquisitions: The Art of the Deal', 'Y'],
      ['DECS-430-5', 'Business Analytics I', 'Y'],
      ['DECS-450-0', 'Decision Making and Modeling', 'Y'],
      ['DECS-452-0', 'Game Theory and Strategic Decisions', 'Y'],
      ['FINC-431-0', 'Finance II', 'Y'],
      ['FINC-444-0', 'Value Investing', 'Y'],
      ['FINC-445-0', 'Entrepreneurial Finance and Venture Capital', 'Y'],
      ['FINC-448-0', 'Mergers and Acquisitions, LBOs and Corporate Restructuring', 'Y'],
      ['FINC-454-0', 'Real Estate Finance and Investments', 'Y'],
      ['FINC-455-0', 'Applied Real Estate Finance and Investments', 'Y'],
      ['FINC-461-0', 'Investment Banking', 'Y'],
      ['FINC-463-0', 'Securities Analysis', 'Y'],
      ['FINC-465-0', 'Derivative Markets I', 'Y'],
      ['FINC-470-0', 'International Finance', 'Y'],
      ['FINC-484-5', 'Thought Leadership Seminar', 'Y'],
      ['FINC-485-3', 'Asset Pricing III', 'Y'],
      ['FINC-486-3', 'Corporate Finance III', 'Y'],
      ['FINC-520-1', 'Time Series Analysis', 'Y'],
      ['FINC-915-0', 'Venture Lab', 'Y'],
      ['FINC-931-0', 'Wall Street, Hedge Funds and Private Equity', 'Y'],
      ['FINC-933-0', 'Asset Management Practicum I', 'Y'],
      ['FINC-936-0', 'Asset Management Practicum IV', 'Y'],
      ['FINC-940-5', 'Financial Modeling for Leveraged Buyout Transactions', 'Y'],
      ['FINC-941-0', 'Macroeconomic Policy and Global Capital Markets', 'Y'],
      ['FINC-945-0', 'Global Entrepreneurial Finance', 'Y'],
      ['HEMA-914-0', 'Biomedical Marketing', 'Y'],
      ['HEMA-924-5', 'Population Health: Healthcare Transformation', 'Y'],
      ['HEMA-926-5', 'Patient-Centric Business Models, Solution and Strategies', 'Y'],
      ['KACI-462-0', 'Leader as Coach', 'Y'],
      ['KACI-468-0', 'Managerial Leadership', 'Y'],
      ['KACI-469-5', 'Leadership: Power, Politics and Talk', 'Y'],
      ['KACI-499-0', 'Independent Study', 'Y'],
      ['KACI-925-5', 'Visualization for Persuasion', 'Y'],
      ['KIEI-903-0', 'Corporate Innovation and New Ventures', 'Y'],
      ['KIEI-920-0', 'Kellogg Innovation Network (KIN) Challenge', 'Y'],
      ['KIEI-925-0', 'Startup Programming and Management', 'Y'],
      ['KIEI-932-0', 'Product Management for Technology Companies: An Entrepreneurial Perspective', 'Y'],
      ['KIEI-935-5', 'Intellectual Property for Entrepreneurs', 'Y'],
      ['KIEI-940-0', 'New Venture Development', 'Y'],
      ['KIEI-942-5', 'New Venture Launch', 'Y'],
      ['KIEI-965-0', 'Global Corporate Governance', 'Y'],
      ['KMCI-930-5', 'Technology in the Age of Analytics', 'Y'],
      ['KMCI-940-5', 'Data Analytics Decisions', 'Y'],
      ['KPPI-441-0', 'Strategy Beyond Markets', 'Y'],
      ['KPPI-454-5', 'The Education Industry', 'Y'],
      ['KPPI-455-5', 'Board Governance of Non-Profit Organizations', 'Y'],
      ['KPPI-460-0', 'Values Based Leadership', 'Y'],
      ['KPPI-471-0', 'Advanced Board Governance', 'Y'],
      ['KPPI-917-5', 'Corporate Social Innovation', 'Y'],
      ['KPPI-973-5', 'Medical Technologies in Developing Countries', 'Y'],
      ['MECN-446-0', 'Pricing Strategies', 'Y'],
      ['MECN-499-0', 'Independent Study', 'Y'],
      ['MECS-478-0', 'Introduction to Applied Econometrics III: Research Design for Causal Inference', 'Y'],
      ['MEDM-915-5', 'Managing Digital Media', 'Y'],
      ['MKTG-451-0', 'Marketing Channel Strategies', 'Y'],
      ['MKTG-453-0', 'Business Marketing', 'Y'],
      ['MKTG-454-0', 'Advertising Strategy', 'Y'],
      ['MKTG-462-0', 'Retail Analytics', 'Y'],
      ['MKTG-468-0', 'Technology Marketing', 'Y'],
      ['MKTG-484-5', 'Thought Leadership Seminar', 'Y'],
      ['MKTG-530-2', 'Special Topics in Marketing', 'Y'],
      ['MKTG-530-3', 'Special Topics in Marketing: Topics in Quantitative Marketing and Economics', 'Y'],
      ['MKTG-550-0', 'Marketing Models: Analytic Modeling', 'Y'],
      ['MKTG-552-0', 'Quantitative Marketing: Bayesian Modeling', 'Y'],
      ['MKTG-925-0', 'Strategic Brand Management', 'Y'],
      ['MKTG-940-0', 'C Suite and Boardroom Dynamics', 'Y'],
      ['MKTG-947-0', 'Consumer Insight Competition', 'Y'],
      ['MKTG-950-0', 'Marketing Consulting Laboratory: Generating Profitable Growth', 'Y'],
      ['MKTG-953-0', 'Customer Analytics', 'Y'],
      ['MKTG-955-0', 'Digital Marketing Analytics', 'Y'],
      ['MKTG-957-0', 'eCommerce and Digital Marketing', 'Y'],
      ['MKTG-962-5', 'Entrepreneurial Selling: Business to Business', 'Y'],
      ['MORS-425-1', 'Behavior In Organizational Systems', 'Y'],
      ['MORS-426-1', 'Micro-Organizational Research Methods', 'Y'],
      ['MORS-453-0', 'Power In Organizations: Sources, Strategies and Skills', 'Y'],
      ['MORS-460-0', 'Leading and Managing Teams', 'Y'],
      ['MORS-476-0', 'Bargaining', 'Y'],
      ['MORS-915-5', 'Human Capital and Enterprise Scaling', 'Y'],
      ['MORS-945-0', 'Social Dynamics and Network Analytics', 'Y'],
      ['MORS-946-5', 'Managing Organizations for Growth', 'Y'],
      ['MORS-955-5', 'Creativity as a Business Tool', 'Y'],
      ['OPNS-454-0', 'Operations Strategy', 'Y'],
      ['OPNS-455-0', 'Supply Chain Management', 'Y'],
      ['OPNS-516-0', 'Stochastic Foundations', 'Y'],
      ['OPNS-525-0', 'Emerging Areas in Operations Managements', 'Y'],
      ['OPNS-917-0', 'Implementing Project Management', 'Y'],
      ['OPNS-923-0', 'Enterprise Risk Management', 'Y'],
      ['OPNS-925-5', 'The Rookie General Manager', 'Y'],
      ['OPNS-940-0', 'Applied Advanced Analytics', 'Y'],
      ['REAL-443-5', 'Urban Economic Development and Real Estate Market Analysis', 'Y'],
      ['REAL-922-5', 'International Real Estate', 'Y'],
      ['STRT-452-0', 'Strategy and Organization', 'Y'],
      ['STRT-460-0', 'International Business Strategy', 'Y'],
      ['STRT-466-0', 'Strategic Challenges in Emerging Markets', 'Y'],
      ['STRT-469-0', 'Analytics for Strategy', 'Y'],
      ['STRT-934-0', 'Managing Turnarounds', 'Y'],
      ['STRT-955-5', 'Strategies for Growth', 'Y'],
      ['BLAW-435-0', 'Business Law', 'Y'],
      ['DECS-431-0', 'Business Analytics II', 'Y'],
      ['DECS-440-0', 'Business Analytics', 'Y'],
      ['FINC-442-0', 'Financial Decisions', 'Y'],
      ['FINC-460-0', 'Investments', 'Y'],
      ['KACI-450-0', 'Persuasive Presentations', 'Y'],
      ['KACI-461-5', 'Personal Leadership Insights', 'Y'],
      ['KIEI-462-0', 'New Venture Discovery', 'Y'],
      ['KPPI-440-5', 'Leadership and Crisis Management', 'Y'],
      ['MECN-430-0', 'Microeconomic Analysis', 'Y'],
      ['MECN-441-0', 'Competitive Strategy and Industrial Structure', 'Y'],
      ['MKTG-430-0', 'Marketing Management', 'Y'],
      ['MKTG-450-0', 'Marketing Research and Analytics', 'Y'],
      ['MKTG-458-0', 'Consumer Insight for Brand Strategy', 'Y'],
      ['MKTG-465-0', 'Launching New Products and Services', 'Y'],
      ['MKTG-466-0', 'Marketing Strategy', 'Y'],
      ['MORS-430-0', 'Leadership in Organizations', 'Y'],
      ['MORS-452-0', 'Leading the Strategic Change Process', 'Y'],
      ['MORS-455-0', 'Strategy Implementation', 'Y'],
      ['MORS-472-5', 'Negotiations Fundamentals', 'Y'],
      ['MORS-474-0', 'Cross-Cultural Negotiation', 'Y'],
      ['OPNS-450-0', 'Analytical Decision Modeling', 'Y'],
      ['OPNS-499-0', 'Independent Study', 'Y'],
      ['STRT-431-0', 'Business Strategy', 'Y'],
      ['STRT-441-0', 'Intellectual Capital Management', 'Y'],
      ['ACCT-452-0', 'Issues in Financial Reporting', 'Y'],
      ['ACCT-520-3', 'Seminar in Information Economics and Analytical Accounting Research', 'Y'],
      ['ACCT-920-0', 'Financial Analysis for Strategic Marketing', 'Y'],
      ['BLAW-911-5', 'Business Law for Entrepreneurs', 'Y'],
      ['FINC-447-0', 'Financial Strategy and Tax', 'Y'],
      ['FINC-451-0', 'Money Markets and the Fed', 'Y'],
      ['FINC-467-0', 'Derivative Markets II', 'Y'],
      ['FINC-485-2', 'Asset Pricing II', 'Y'],
      ['FINC-486-2', 'Corporate Finance II', 'Y'],
      ['FINC-935-0', 'Asset Management Practicum III', 'Y'],
      ['FINC-937-0', 'Micro-finance and Financial Inclusion', 'Y'],
      ['FINC-946-0', 'Impact Investing', 'Y'],
      ['HEMA-453-0', 'Critical Issues in the Pharmaceutical, Biotech, and Medical Device Industries', 'Y'],
      ['INTL-473-0', 'Global Initiatives in Management (GIM)', 'Y'],
      ['KACI-467-0', 'Perspectives on Leadership', 'Y'],
      ['KIEI-905-5', 'Entrepreneurship Through Acquisition', 'Y'],
      ['KIEI-911-0', 'Medical Product Early Stage Commercialization', 'Y'],
      ['KIEI-967-0', 'Launching and Leading Startups', 'Y'],
      ['KPPI-450-0', 'Leading Mission Driven Enterprises', 'Y'],
      ['KPPI-470-0', 'Public Economics for Business Leaders: Federal Policy', 'Y'],
      ['KPPI-484-0', 'Thought Leadership Seminar', 'Y'],
      ['KPPI-933-0', 'Health and Human Rights', 'Y'],
      ['MEDM-432-0', 'Understanding the Media and Content', 'Y'],
      ['MKTG-530-1', 'Special Topics in Marketing: Problems and Solutions in Applied Data Analyses', 'Y'],
      ['MKTG-540-0', 'Theory Building and Testing in Consumer Psychology- Part A', 'Y'],
      ['MKTG-541-0', 'Psychological Theory in Consumer Behavior', 'Y'],
      ['MKTG-551-0', 'Quantitative Marketing: Introduction to Theory and Empirical Methods', 'Y'],
      ['MKTG-946-5', 'Marketing Strategy Challenge', 'Y'],
      ['MKTG-961-5', 'Entrepreneurial Tools for Digital Marketing', 'Y'],
      ['MORS-424-2', 'Social Processes In Organizations', 'Y'],
      ['MORS-426-2', 'Macro-Organizational Research Methods', 'Y'],
      ['MORS-451-0', 'Designing Organizational Systems', 'Y'],
      ['MORS-462-5', 'Leading and Managing Diverse Organizations', 'Y'],
      ['MORS-470-0', 'Negotiations', 'Y'],
      ['MORS-530-0', 'Special Topics in Management and Organizations', 'Y'],
      ['MORS-910-5', 'Sports and People Analytics', 'Y'],
      ['MORS-920-5', 'Social Media and Reputation', 'Y'],
      ['OPNS-521-0', 'Foundations of Operations Management', 'Y'],
      ['REAL-925-0', 'Real Estate Entrepreneurship', 'Y'],
      ['STRT-927-0', 'Family Enterprises: Issues and Solutions', 'Y'],
      ['STRT-945-0', 'Healthcare Strategy', 'Y'],
      ['STRT-950-5', 'Competitive Strategy in Financial Services Markets', 'Y'],
      ['STRT-951-5', 'Innovation in Financial Services Markets', 'Y'],
      ['KIEI-924-0', 'Introduction to Software Development', 'Y']
    ]
  end
end