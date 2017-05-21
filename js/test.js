$(document).ready(function(){
		var total_score = 0;
		var total_score_display = "";
		var cur_score = 0;
		var cur_question_no = 0;
		var stopFlag = false;
		var answerFlag = true;

		var questions = ["Hur ofta tänker du dig att allt skulle lösas om din kille bara gjorde som du sa.",
										 "Hur ofta fantiserar du om att göra slut eller vara med någon bättre?",
										 "Hur ofta gnäller du på din kille?",
										 "Hur ofta känner du dig överlägsen över din kille?",
										 "Hur ofta är nån av er inte intresserad av sex?",
										 "Hur ofta känner du att han inte bryr sig om vad du vill?",
										 "När du pratar med dina vänner, hur ofta klagar du på din kille?",
										 "Hur ofta känner du dig nedstämd och tillbakadragen?",
										 "Hur ofta känner du dig avundsjuk eller bitter på det din kille åstadkommit?",
										 "Hur ofta när han försöker göra något schysst hackar du ändå på det?"];

		$(".intimacy-test__question.text-align-left.el1").html(questions[0]);
		$(".intimacy-test__question.text-align-left.el1").fadeIn();

		function calcScore() {	
			if (stopFlag || !answerFlag)
				return;

			cur_question_no += 1;
			total_score += cur_score;

			if (cur_question_no > 9)  {
				displayResult();
				stopFlag = true;
				return;
			}

			setTimeout(function() { 
				$(".intimacy-test__question.text-align-left.el1").html(questions[cur_question_no]);
			}, 400);
			setTimeout(function() {
				answerFlag = true;
			}, 600);
			answerFlag = false;
			$(".intimacy-test__question.text-align-left.el1").fadeOut();
			$(".intimacy-test__question.text-align-left.el1").fadeIn();

			$(".intimacy-test__number:even").html(((cur_question_no % 10 ) + 1) + "/10");
			$(".intimacy-test__number:odd").html("Score: " + total_score + "%");
			$(".intimacy-test__progress-bar.intimacy-test__progress-bar--progress.el1").css("width", (cur_question_no * 10 + "%"));
			$(".intimacy-test__progress-bar.intimacy-test__progress-bar--progress.el2").css("width", total_score + "%");
		}

		function displayResult() {
			if (total_score >= 20 && total_score < 36) {
				total_score_display = "You got low score.";
			}
			if (total_score >= 36 && total_score < 76) {
				total_score_display =  "You got medium score.";
			}
			if (total_score >= 76 && total_score <= 100) {
				total_score_display =  "You got high score.";
			}
			setTimeout(function(){
				$(".intimacy-test__question.text-align-left.el1").html(total_score_display);
			}, 400);

			$(".intimacy-test__question.text-align-left.el1").fadeOut();
			$(".intimacy-test__question.text-align-left.el1").fadeIn();
			$(".intimacy-test__number:even").html("Score: " + total_score);
			$(".intimacy-test__number:odd").hide();
			$(".intimacy-test__option").hide();
			$(".intimacy-test__progress-bar.el2").hide();
			$(".intimacy-test__progress-bar.intimacy-test__progress-bar--progress.el1").css("width", "100%");
			setTimeout(function(){
				$(".intimacy-test__progress-bar.intimacy-test__progress-bar--progress.el1").css("width", total_score + "%");
			}, 600);
			
		}

		$(".intimacy-test__option:first").on("click", function() {
			cur_score = 2;
			calcScore();
		})

		$(".intimacy-test__option:odd").on("click", function() {
			cur_score = 5;
			calcScore();
		})

		$(".intimacy-test__option:last").on("click", function() {
			cur_score = 10;
			calcScore();
		})
	})