# Documentation:
#  - Test Parameters: https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit#test-parameters
#  - Test Cases: https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-cases
@{
    # Test = @( )
    Skip = @(
        'Template Should Not Contain Blanks',
        'DeploymentTemplate Must Not Contain Hardcoded Uri'
        'DependsOn Best Practices',
        'Outputs Must Not Contain Secrets',
        'IDs Should Be Derived From ResourceIDs'
    )
}
