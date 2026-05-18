(function ($) {
    "use strict";

    function reparseValidation(form) {
        // AJAX replaces the field DOM, so unobtrusive validation must be rebuilt against the new DB-driven rules.
        $(form)
            .removeData("validator")
            .removeData("unobtrusiveValidation");

        $.validator.unobtrusive.parse(form);
    }

    $(function () {
        var $form = $("#educationForm");
        var $educationLevel = $("#EducationLevelId");
        var $fieldsContainer = $("#educationFields");

        reparseValidation($form);

        $educationLevel.on("change", function () {
            var educationLevelId = $(this).val();
            var fieldsUrl = $(this).data("fields-url");

            $fieldsContainer.empty();

            if (!educationLevelId) {
                reparseValidation($form);
                return;
            }

            $.ajax({
                url: fieldsUrl,
                type: "GET",
                data: { educationLevelId: educationLevelId },
                beforeSend: function () {
                    $fieldsContainer.html('<div class="col-12"><div class="alert alert-info mb-0">Loading education fields...</div></div>');
                },
                success: function (html) {
                    $fieldsContainer.html(html);
                    reparseValidation($form);
                },
                error: function () {
                    $fieldsContainer.html('<div class="col-12"><div class="alert alert-danger mb-0">Unable to load education configuration. Please try again.</div></div>');
                    reparseValidation($form);
                }
            });
        });
    });
})(jQuery);
