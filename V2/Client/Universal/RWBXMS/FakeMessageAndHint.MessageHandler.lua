script.Parent.Parent.Changed:Connect(function()
	script.Parent.Value = script.Parent.Parent.Text
	script.Parent.Parent.Text = ""
end)
