Given /^I am on the new date page$/ do
  tree = @flex.tree({:id => 'objectTree'})
  tree.open('Date controls')
  tree.select('Date controls>DateField1')
end

When /^I select date (.*)$/ do |date|
  date_field = @flex.date_field({:id => 'dateField1'})
  date_field.open
  date_field.change(date)
end

Then /^I should see (.*) as my date$/ do |date|
  date_field = @flex.date_field({:id => 'dateField1'})
  date_field.selected_date.to_s.should == Date.parse(date).to_s
end
