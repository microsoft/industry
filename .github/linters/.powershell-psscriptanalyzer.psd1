#Documentation: https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/markdown/Invoke-ScriptAnalyzer.md#-settings
@{
    #CustomRulePath='path\to\CustomRuleModule.psm1'
    #RecurseCustomRulePath='path\of\customrules'
    #Severity = @(
    #    'Error'
    #    'Warning'
    #)
    #IncludeDefaultRules=${true}
    ExcludeRules = @(
       'PSUseShouldProcessForStateChangingFunctions',
       'PSReviewUnusedParameter'
       'PSAvoidGlobalVars'
       'PSAvoidUsingPlainTextForPassword'
       'PSAvoidUsingConvertToSecureStringWithPlainText'
       'PSPossibleIncorrectUsageOfAssignmentOperator'
    )
    #IncludeRules = @( )
}
