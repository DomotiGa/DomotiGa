--
-- add device actions
--
-- alter devices table to store action ID's
ALTER TABLE `devices` ADD `action_on_id` INT(11) NOT NULL AFTER `location_id`, ADD `action_off_id` INT(11) NOT NULL AFTER `action_on_id`;

-- update action table to have "no action defined"
SET SESSION SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
INSERT INTO `actions` (`id`, `name`, `type`, `description`, `param1`, `param2`, `param3`, `param4`, `param5`) VALUES
(0, 'No action defined', 1, 'No action defined', '1', '1', 'On', '', '');

SET SESSION SQL_MODE = ''
