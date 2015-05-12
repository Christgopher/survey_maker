require "spec_helper"

describe(Survey) do
  it("capitalizes the first letter") do
    survey = Survey.create({:title => 'poop'})
    expect(survey.title()).to(eq("Poop"))
  end
end
